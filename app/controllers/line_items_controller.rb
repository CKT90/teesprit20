class LineItemsController < ApplicationController

  def create
    product = Product.find_by(id: params[:line_item][:product_id])
    quantity = params[:line_item][:quantity]
    real_variant = params[:line_item][:option_value_ids].nil? ? product.variants.first : product.find_variant(params[:line_item][:option_value_ids])
    @line_item = @cart.add_product_variant(real_variant, quantity.to_i)

    if @line_item.save
      respond_to do |format|
        format.html
        format.js
      end
    else
      respond_to do |format|
        format.html {redirect_to store_url}
        format.js
      end 
    end
  end

  def update_multiple
    params[:line_item].each do |line_id, line_value|
      line_value.each do |q, quantity|
        LineItem.find_by(id: line_id).update(quantity: quantity)
      end
    end
    flash[:success] = "Successfully updated!"
    redirect_to @cart
  end


  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    flash[:success] = "Item Removed."
    redirect_to @cart
  end

  private

  def line_item_params
    params.require(:line_item).permit(:variant_id, :quantity, :line_item, :final_price)
  end

end
