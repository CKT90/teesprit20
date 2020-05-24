class CartsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
     if @cart.line_items.empty?
      flash[:info] = "Your cart is empty, shop here!"
      redirect_to store_url
     end
  end

  def destroy
    if logged_in?
      Cart.destroy(cookies[:cart_id])
      cookies[:cart_id] = nil
      redirect_to store_url
    else
      Cart.destroy(cookies[:guest_cart_id])
      cookies[:guest_cart_id] = nil
      redirect_to store_url
    end
  end

  private

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to store_url, notice: 'Invalid cart'
  end
    
end
