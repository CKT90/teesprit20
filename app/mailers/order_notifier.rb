class OrderNotifier < ApplicationMailer

  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end

  def received(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end
end
