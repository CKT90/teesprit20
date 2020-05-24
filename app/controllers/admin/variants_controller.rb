class Admin::VariantsController < Admin::BaseController

	def manage
    	@product = Product.find(params[:product_id])
    end

	def edit
		@product = Product.find(params[:product_id])
		@variant = @product.variants.find(params[:id])
	end

  def update
      @product = Product.find(params[:product_id])
      @variant = @product.variants.find(params[:id])

      respond_to do |format|
        if @variant.update(variant_params)
          format.html {redirect_to edit_admin_product_variant_path(@product, @variant)
                       flash[:success] = "Successfully updated!"}
          format.json { respond_with_bip(@variant) }
        else
          format.html {redirect_to edit_admin_product_variant_url(@product, @variant), :flash => {:danger =>  @variant.errors.full_messages.join("\n") }}
          format.json { respond_with_bip(@variant) }
        end
      end
	end

  def update_active_status
    @variant = Variant.find_by(id: params[:variant][:id])
    @variant.update(active: params[:variant][:active])
    redirect_to(:back)
  end

    
private

    def variant_params
      params.require(:variant).permit(:id, :active, :hidden, :SKU, :description, :count_on_hand, :cost_price, :price, :image_ids => [])
    end


end
