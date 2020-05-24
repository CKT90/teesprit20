
class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    @notification = PaymentNotification.create!(:params => params, :invoice_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id] )

    if @notification.status == "Pending" ||  @notification.status == "Completed"
    	redirect_to paypal_url(:notification_id => @notification.id)
    else
    	render :nothing => true
    end

  end
end

