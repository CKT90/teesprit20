class Order < ActiveRecord::Base
	PAYMENT_TYPES = [ "Cash on Delivery (COD)", "Bank-in (Delivery)", "Credit Card" ]

	as_enum :shipment_status, %w{pending shipped}, prefix: true
	as_enum :order_status, %w{pending approved canceled}, prefix: true
	as_enum :payment_status, %w{pending paid}, prefix: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_one :payment_notification
	belongs_to :users
	has_many :line_items, dependent: :destroy
	validates :name, :address, :states, presence: true
	validates :pay_type, inclusion: PAYMENT_TYPES
	validates :contact_number, :numericality => {:only_integer => true}

    extend FriendlyId
    friendly_id :number, slug_column: :number, use: [:slugged,:finders]
    include NumberGenerator.new(prefix: 'R')


	def total_order_selling_price
		total_order_cost + total_order_net_profit
	end
	
	def total_order_cost
		line_items.to_a.sum {|x| x.final_cost * x.quantity}
	end

	def total_order_net_profit
		line_items.to_a.sum {|x| x.final_price - x.final_cost}
	end

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
			item.final_price = item.variant.price
			item.final_cost = item.variant.cost_price
		end
	end


	def update_stock
		line_items.each do |line_item|
			removed_quantity = line_item.quantity
			final_quantity = line_item.variant.count_on_hand - removed_quantity
			line_item.variant.update_attribute(:count_on_hand, final_quantity)
			LineItem.where(variant_id: line_item.variant.id, :order_id => nil).each do | update_li|
				if update_li.quantity > final_quantity
				update_li.update_attribute(:quantity, final_quantity)
				LineItem.where(quantity: 0).delete_all
				end
			end
		end
	end

	def update_canceled_quantity
		if self.order_status_cd == 2
			self.line_items.each do |line|
				current_q = Variant.find_by(id: line.variant.id).count_on_hand
				if Product.find_by(id: line.variant.product_id).hidden == false
					current_q += line.quantity
				else
					current_q
				end
				Variant.find_by(id: line.variant.id).update_attribute(count_on_hand: current_q)
			end
		end
	end

	def update_hidden_quantity
		if self.hidden == true
			self.line_items.each do |line|
				current_q = Variant.find_by(id: line.variant.id).count_on_hand
				if Product.find_by(id: line.variant.product_id).hidden == false
					current_q += line.quantity
				else
					current_q
				end
				Variant.find_by(id: line.variant.id).update_attribute(count_on_hand: current_q)
			end
		end
	end

	def update_shipping_and_total
		if self.pay_type == "Bank-in (Delivery)" || self.pay_type == "Credit Card"
			if ['Perlis', 'Penang', 'Perak', 'Kedah', 'Terengganu', 'Johor', 'Melaka', 'Negeri Sembilan', 'Pahang', 'Kelantan'].include?(self.states)
				self.update_attribute(:delivery_cost, '10')
			elsif ['Kuala Lumpur', 'Selangor'].include?(self.states)
				self.update_attribute(:delivery_cost, '0')	
			elsif ['Sabah', 'Sarawak', 'Labuan'].include?(self.states)
				self.update_attribute(:delivery_cost, '12')			
			end
		elsif self.pay_type == "Cash on Delivery (COD)"
			self.update_attribute(:delivery_cost, '0')
		end
		grand_total_price = total_order_selling_price + delivery_cost
		self.update_attribute(:grand_total_price, grand_total_price)
	end

	end
	
	private

end
