class Cart < ActiveRecord::Base

	has_many :line_items, dependent: :destroy
	belongs_to :user

	def add_product_variant(variant, quantity)
		current_item = line_items.find_by(variant_id: variant.id)
			if current_item
				current_item.quantity += quantity 
				if current_item.quantity >= variant.count_on_hand
					current_item.update(quantity: variant.count_on_hand)
				end
			else
				current_item = line_items.build(variant_id: variant.id, quantity: quantity)
			end
		current_item
	end

	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end


	def current_cart
	   current_user.current_cart if current_user.present?
	end

	def total_line_item
		line_items.count.to_i
	end

	def grand_total 
		line_items.to_a.sum { |item| item.total_price }
	end

end





