class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:edit, :update]
  #rescue_from ActiveRecord::RecordNotFound, with: :invalid_product
  before_action :set_option, only: [:new, :create]

  
  def index
    @search = Product.ransack(params[:q])
    @products = @search.result.where.not(hidden: true).paginate(:page => params[:page], :per_page => 10).order('updated_at DESC')
  end

  def new
    @product = Product.new
  end

  def edit
    @images=@product.images
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to edit_admin_product_url(@product)
      flash.now[:success] = "Product successfully created!"
    else
      render :new 
      flash.now[:danger] = "Unsuccessful creation, please try again!"
    end
  end

  def update
      if @product.update(product_edit_params)
        unless params[:product][:images_attributes].nil?
          params[:product][:images_attributes].each do |image|
            @image = @product.images.create(:image => image)
          end
        end
        flash[:success] = "Successfully updated!" 
        redirect_to edit_admin_product_url(@product)
      else
        redirect_to edit_admin_product_url(@product), :flash => { :danger => @product.errors.full_messages.join(', ') }
      end
  end

  def remove
    @product = Product.find(params[:product_id])
    @product.update(:hidden, true)
    
    @product.variants.each do |var|
      var.update(:count_on_hand, "0")

      Cart.all.each do |cart|
        cart.line_items.each do |line_item|
          if line_item.variant_id == var.id
            line_item.delete
          end
          cart.save!
        end
      end
    end
    redirect_to :admin_products
  end

  def revive
    @product = Product.find(params[:product_id])
    @product.update(:hidden, false)
    redirect_to :admin_products
  end

  def update_image_positions
    params[:image_entry].each_with_index do |id, index|
    Image.where(id: id).update_all(position: index + 1)
  end
    render nothing: true
  end

  def update_properties_positions
    params[:entry].each_with_index do |id, index|
    Property.where(id: id).update_all(position: index + 1)
  end
    render nothing: true
  end

  def manage_properties
    @product = Product.find(params[:product_id])
    @product.properties.build if @product.properties.empty?
  end

  def deleted_index
    @search = Product.search(params[:q])
    @products = @search.result.where.not(hidden: false).paginate(:page => params[:page], :per_page => 15).order('updated_at DESC')
  end

  private
  
    def set_product
      @product = Product.find(params[:id])
    end  

    def set_option
      @ProperOptionType = OptionType.joins(:option_values).group("option_types.id").group("option_type_id").having("count(option_values.id) >= ?",1)
    end

    def product_params
      params.require(:product).permit(:title, :description, :option_type_ids => [])
    end

    def product_edit_params
      params.require(:product).permit( :number, :state_cd, :id, :title, :description, :available_on, :discontinue_on, images_attributes:[:id, :image])
    end

    def invalid_product
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to products_url, notice: 'Invalid product'
    end

end

