class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper
  include CartsHelper
  include ProductsHelper
  before_action :set_cart

  private

  def set_cart
    if logged_in?
      @cart = current_user.cart ? current_user.cart : current_user.create_cart
      cookies[:cart_id] = { value: @cart.id, expires: 7.days }
    else
      @cart = cookies[:guest_cart_id] ? Cart.find_by(id: cookies[:guest_cart_id]) : Cart.create!
      cookies[:guest_cart_id] = { value: @cart.id, expires: 1.days }
      cookies[:cart_id] = nil
    end
  end

end
