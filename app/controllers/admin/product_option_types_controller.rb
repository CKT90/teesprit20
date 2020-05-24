class Admin::ProductOptionTypesController < Admin::BaseController
  before_action :set_product_option_type, only: [:update]

  def update
      @product_ov.update(hidden: params[:option_type][:hidden])
      redirect_to admin_product_path(@product) 
  end

  def update_two
      @product = Product.find_by(id: params[:product_id])
      @product_ov = ProductOptionType.find_by(product_id: params[:product_id], option_type_id: params[:option_type_id])
      @product_ov.update(hidden: params[:status])
      render body: nil
  end

  private
    def set_product_option_type
      @product = Product.find_by(id: params[:option_type][:product_id])
      @product_ov = ProductOptionType.find_by(product_id: params[:option_type][:product_id], option_type_id: params[:option_type][:option_type_id])
    end

    def product_ov_params
      params.require(:category).permit(:hidden)
    end
end
