  class StripeNotification
    def call(event)
      begin
        method = "handle_" + event.type.tr('.', '_')
        self.send method, event
      rescue JSON::ParserError => e
        # handle the json parsing error here
        raise 
      rescue NoMethodError => e
        #code to run when handling an unknown event
        raise 
      end
    end

    def handle_checkout_session_completed(event)
      @client_reference_id = event.data.object.client_reference_id
      @payment_intent_id = event.data.object.payment_intent

      @receipt_number = Stripe::PaymentIntent.retrieve(@payment_intent_id,).charges.data[0].receipt_number

      @order = Order.find_by(number: @client_reference_id)
      @order.update_attribute(:stripe_transaction_id, @receipt_number)
    end

  end

