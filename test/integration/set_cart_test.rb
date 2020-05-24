require 'test_helper'

class SetCartTest < ActionDispatch::IntegrationTest

  def setup
  	@user = users(:michael) #setting a fixture
  end

  test "should create guest cart if not logged in" do
    get root_path
   	assert_not_nil cookies[:guest_cart_id]
   	assert_nil cookies[:cart_id]
  end

  test "should create user cart if logged in, and create guest cart after logged out" do
    get root_path
   	assert_not_nil cookies[:guest_cart_id]
   	assert_nil cookies[:cart_id]   
  	log_in_as(@user)
  	assert_redirected_to(controller: "orders", action: "index") 
   	assert_not_nil cookies[:cart_id]
    assert_equal cookies[:guest_cart_id], ""

    delete logout_path
    assert_equal cookies[:cart_id], ""
    assert_not_nil cookies[:guest_cart_id]
  end
  
end

