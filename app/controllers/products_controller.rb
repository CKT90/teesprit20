class ProductsController < ApplicationController

  before_action :set_product, only: [:check_stock]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_product

  def show
    @product = Product.includes(:images, :variants).friendly.find(params[:id])
    if @product.discontinued?
      flash[:danger] = "Product not available at the moment!"
      redirect_to store_url
    end
  end

  def check_stock
    unless params[:option_values].nil? 
      variant = @product.find_variant(params[:option_values])
    else
      variant = @product.variants.first
    end
    quantity = variant.count_on_hand
    description = variant.description
    price = variant.price
    respond_to do |format|
      if quantity > 0
        format.json {render json: {:quantity => quantity, :description => description, :color => "#f4bb5f", :price => price}}
      else
        format.json {render json: {:quantity => quantity, :description => description, :color => "#FF5733", :price => price}}
      end
    end
  end


  private

    def set_product
      @product = Product.friendly.find(params[:id])
    end

    def invalid_product
      logger.error "Attempt to access invalid product #{params[:id]}"
      flash[:danger] = "Error 404: Invalid Product!"
      redirect_to store_url
    end

end
