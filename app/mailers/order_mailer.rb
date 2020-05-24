class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_summary.subject
  #
  def order_summary(order)
    @order = order
    mail to: User.find(order.user_id).email, subject: 'Teesprit, Order Created and Processing'
  end

  def order_admin_notification(order)
    @order = order
    mail to: "teesprit20@gmail.com", subject: 'Teesprit, Order Created by new buyer!'
  end


  def order_shipped(order)
    @order = order
    mail to: User.find(order.user_id).email, subject: 'Teesprit, Order Shipped'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_cancellation.subject
  #
  def order_cancellation(order)
    @order = order
    mail to: User.find(order.user_id).email, subject: 'Teesprit, Order Cancellation Request'
  end
end
