    Stripe.api_key = Rails.application.secrets.stripe_secret_key
    StripeEvent.signing_secret = Rails.application.secrets.stripe_signing_secret

    StripeEvent.configure do |events|
	  events.subscribe 'checkout.session.completed', StripeNotification.new
	end