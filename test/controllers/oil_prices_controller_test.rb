require 'test_helper'

class OilPricesControllerTest < ActionController::TestCase
  setup do
    @oil_price = oil_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oil_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create oil_price" do
    assert_difference('OilPrice.count') do
      post :create, oil_price: { daily_oil_price: @oil_price.daily_oil_price, date: @oil_price.date }
    end

    assert_redirected_to oil_price_path(assigns(:oil_price))
  end

  test "should show oil_price" do
    get :show, id: @oil_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @oil_price
    assert_response :success
  end

  test "should update oil_price" do
    patch :update, id: @oil_price, oil_price: { daily_oil_price: @oil_price.daily_oil_price, date: @oil_price.date }
    assert_redirected_to oil_price_path(assigns(:oil_price))
  end

  test "should destroy oil_price" do
    assert_difference('OilPrice.count', -1) do
      delete :destroy, id: @oil_price
    end

    assert_redirected_to oil_prices_path
  end
end
