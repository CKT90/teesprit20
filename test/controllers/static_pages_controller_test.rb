require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Home | Teesprit"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | Teesprit"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | Teesprit"
  end

  test "should get pay method" do
    get :pay_method
    assert_response :success
    assert_select "title", "Payment | Teesprit"
  end

  test "should get pay product details" do
    get :about_product
    assert_response :success
    assert_select "title", "Product | Teesprit"
  end

  test "should get refund" do
    get :refund
    assert_response :success
    assert_select "title", "Refund | Teesprit"
  end
end
