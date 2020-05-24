class OrdersController < ApplicationController

  def index
    @orders = current_user.orders.order('created_at DESC').includes(:line_items)
    @products = Product.all.includes(:images)
    @user = User.find(current_user.id) 
  end

  def new
    if @cart.line_items.empty?
     flash[:success] = "Your cart is empty, shop here!"
     redirect_to store_url
    else
      if current_user.nil?
        flash[:success] = "Please create an account to proceed"
        redirect_to signup_path
      else
        @order = Order.new(:name => current_user.name, :address => current_user.address, :contact_number => current_user.contact_number)
      end
    end
  end


  def create

    unless logged_in?
      flash[:success] = "Please create an account to proceed"
      redirect_to signup_path
    end

    @order = current_user.orders.build(order_params)
    @payment_choice = params[:order][:pay_type]
    @order.add_line_items_from_cart(@cart) #method at order model
      
    if @order.save
      @order.update_stock
      @order.update_shipping_and_total
      @order.update_attribute(:email, current_user.email)
      Cart.destroy(cookies[:cart_id])
      cookies[:cart_id] = nil

      if @payment_choice == "Cash on Delivery (COD)" || @payment_choice == "Bank-in (Delivery)" 
        flash[:info] = "Your Order Had Been Created! We had sent you an email with instructions to proceed with the transaction, thanks!"
        redirect_to store_path
      elsif @payment_choice == "Paypal" || @payment_choice == "Credit Card"
        redirect_to order_url(@order) 
      else 
        flash.now[:info] = "Please choose a payment type!"
        render :new
      end

      OrderMailer.order_summary(@order).deliver_now
      OrderMailer.order_admin_notification(@order).deliver_now
    else
      render :new
    end
  end


  def show
    @order = Order.find(params[:id])
    if @order.pay_type == "Credit Card"
      unless @order.stripe_transaction_id.nil?  
        redirect_to store_url
      end
    elsif @order.pay_type == "Paypal"
      unless @order.paypal_transaction_id.nil? 
        redirect_to store_url 
      end
    elsif @order.pay_type == "Cash on Delivery (COD)" || @order.pay_type == "Bank-in (Delivery)"
      redirect_to store_url
    end
  end


  def process_paypal
    @notification = PaymentNotification.find(params[:notification_id])
    @order = Order.find_by(number: @notification.invoice_id)
    @order.update(:payment_remarks, "PAYPAL payment #{@notification.status} #{Time.zone.now} ")
    @order.update(:paypal_transaction_id, @notification.transaction_id)
    OrderMailer.order_summary(@order).deliver_now
    OrderMailer.order_admin_notification(@order).deliver_now
    render :nothing => true
  end


private

  def order_params
    params.require(:order).permit(:name, :address, :contact_number, :pay_type, :states, :delivery_cost, :total_price)
  end

end


