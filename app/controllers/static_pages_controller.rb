class StaticPagesController < ApplicationController

  def home
    @product = Product.select{|x| x.images.count > 0 && x.available? }.last(3).reverse
  end

  def contact
    @message = Message.new(:content => params[:content], :subject => params[:subject], :sender_email => params[:sender_email])
  end

  def about
  end

  def pay_method
  end

  def about_product
  end

  def refund
  end

end
