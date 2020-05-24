class StripeCheckoutsController < ApplicationController
    skip_before_action :verify_authenticity_token

    Stripe.api_key = Rails.application.secrets.stripe_secret_key

    def stripe_checkout_session
        @order = Order.find(params[:id])
        session = Stripe::Checkout::Session.create(
            client_reference_id: @order.number,
            customer_email: @order.email,
            payment_method_types: ['card'],
            line_items:  @order.delivery_cost > 0 ? @order.line_items.map {|item| {"name" => Product.find(item.variant.product_id).title, "currency"=>"myr", "amount" => (item.final_price * 100).to_i, "quantity" => item.quantity}}<< {"name" => "Shipping", "currency" => "myr", "amount" => (@order.delivery_cost * 100).to_i, "quantity" => 1} : @order.line_items.map {|item| {"name" => Product.find(item.variant.product_id).title, "currency"=>"myr", "amount" => (item.final_price * 100).to_i, "quantity" => item.quantity}},
            success_url: root_url,
            cancel_url: root_url,
        )

        render json: { session_id: session.id, publishable_key: Rails.application.secrets.stripe_publishable_key  }
    end

end

