module CartsHelper


  	def update_cart(guest_cart_id)

	  if guest_cart_id 
	  	@guest_cart = Cart.find_by(id: guest_cart_id)
	  	
	  	@cart = current_user.cart ? current_user.cart : current_user.create_cart
        cookies[:cart_id] = { value: @cart.id, expires: 7.days }


		@guest_cart.line_items.each do |li|
	  		
	  		current_item = @cart.line_items.find_by(variant_id: li.variant_id)
	  		variant = Variant.find(li.variant_id)
	  		 if current_item
				current_item.quantity += li.quantity				
				if current_item.quantity >= variant.count_on_hand
					current_item.update(quantity: variant.count_on_hand)
				end
			else
	  		 	current_item = @cart.line_items.build(variant_id: li.variant_id, quantity: li.quantity)	
			end	
			current_item.save!
	  	end
	  	
	  	Cart.destroy(guest_cart_id)
	  	cookies.delete :guest_cart_id
	  else
	  end

	end

	
end


