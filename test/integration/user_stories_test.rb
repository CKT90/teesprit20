require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
fixtures :products #load all fixtures of products

 test "buying a product" do

 	product_dog = products(:dog)
 	option_value = option_values(:black)
 	@user = users(:michael)
 	variant_two = variants(:dog_two)

 	log_in_as(@user)
 	get "/products/#{product_dog.id}"
 	assert_response :success

 	assert_template "products/show"
	post addcart_path, params: {line_item: { product_id: product_dog.id, option_value_ids: [option_value.id], quantity: 1}}, xhr: true
 	assert_response :success

 	cart = Cart.find(cookies[:cart_id])
 	assert_equal 1, cart.line_items.size
 	assert_equal variant_two, Variant.find(cart.line_items[0].variant_id)
	
# 	get "/orders/new"
# 	assert_response :success
# 	assert_template "new"
	
# 	post_via_redirect "/orders",
# 		order: { name: "Dave Thomas",
# 				 address: "123 The Street",
# 				 email: "dave@example.com",
# 				 pay_type: "Check" }
# 	assert_response :success
# 	assert_template "index"
# 	cart = Cart.find(session[:cart_id])
# 	assert_equal 0, cart.line_items.size

# 	orders = Order.all
# 	assert_equal 1, orders.size
# 	order = orders[0]

# 	assert_equal "Dave Thomas", order.name
# 	assert_equal "123 The Street", order.address
# 	assert_equal "dave@example.com", order.email
# 	assert_equal "Check", order.pay_type

# 	assert_equal 1, order.line_items.size
# 	line_item = order.line_items[0]
# 	assert_equal ruby_book, line_item.product
	
# 	mail = ActionMailer::Base.deliveries.last
# 	assert_equal ["dave@example.com"], mail.to
# 	assert_equal 'noreply@example.com', mail[:from].value
# 	assert_equal "Pragmatic Store Order Confirmation", mail.subject
 	end
end
