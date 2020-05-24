class Admin::OrdersController < Admin::BaseController

  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :update, :destroy]


  def index
    @search = Order.search(params[:q])
    @orders = @search.result.where.not(hidden: true).paginate(:page => params[:page], :per_page => 10).order('updated_at DESC')
  end

  def deleted_index
    @search = Order.search(params[:q])
    @orders = @search.result.where.not(hidden: false)
  end

  def new
    @order = Order.new
  end

  def sales_report
    @search = Order.search(params[:q])
    @orders = @search.result.order('updated_at DESC')
    @qualified_orders = @orders.where.not(hidden: true).where.not(order_status_cd: "0").where.not(order_status_cd: "2")
    @real_orders = Order.where.not(hidden: true).where.not(order_status_cd: "0").where.not(order_status_cd: "2")
    @total_orders = Order.all
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart) #method at order model

      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderNotifier.received(@order).deliver_now
        redirect_to store_url, notice: 'Thank you for your order.' 
      else
        render :new 
    end
  end

  def update
    if @order.update(order_params)
      @order.update_canceled_quantity
      redirect_to admin_order_manage_order_path(@order)
      flash[:success] = "Order updated."
    else
       render :edit 
    end
  end

  def manage_order
    @order = Order.find(params[:order_id])
    @user = User.find(@order.user_id)
    # rescue ActiveRecord::RecordNotFound => e //dunno wtf
    # @user = nil //dunno wtf
  end

  def update_order_payment_status
    @order = Order.find(params[:order_id])
    @order.update_attribute(:payment_status_cd,params[:status])
    respond_to do |format|
      format.json { head :ok}
      format.html { head :ok}
    end
  end

  def update_order_shipment_status
    @order = Order.find(params[:order_id])
    @order.update_attribute(:shipment_status_cd, params[:status])
    OrderMailer.order_shipped(@order).deliver_now
    respond_to do |format|
      format.json { head :ok}
      format.html { head :ok}
    end
  end

  def update_order_payment_remarks
    @order = Order.find(params[:order_id])
    @order.update_attribute(:payment_remarks,params[:remarks])
    respond_to do |format|
      format.json { head :ok}
      format.html { head :ok}
    end
  end

  def update_order_shipment_remarks
    @order = Order.find(params[:order_id])
    @order.update_attribute(:shipment_remarks,params[:remarks])
    respond_to do |format|
      format.json { head :ok}
      format.html { head :ok}
    end
  end

  def remove
    @order = Order.find(params[:order_id])
    @order.update_attribute(:hidden, true)
    @order.update_attribute(:shipment_status_cd, 2)
    @order.update_attribute(:order_status_cd, 2)
    @order.update_hidden_quantity
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:hidden, :name, :address, :email, :states, :pay_type, :contact, :shipment_remarks, :payment_remarks, :payment_confirmation_date, :shipment_confirmation_date, :order_status_cd)
    end
end

