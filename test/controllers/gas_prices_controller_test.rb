require 'test_helper'

class GasPricesControllerTest < ActionController::TestCase
  setup do
    @gas_price = gas_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gas_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gas_price" do
    assert_difference('GasPrice.count') do
      post :create, gas_price: { daily_price: @gas_price.daily_price, gas_type: @gas_price.gas_type }
    end

    assert_redirected_to gas_price_path(assigns(:gas_price))
  end

  test "should show gas_price" do
    get :show, id: @gas_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gas_price
    assert_response :success
  end

  test "should update gas_price" do
    patch :update, id: @gas_price, gas_price: { daily_price: @gas_price.daily_price, gas_type: @gas_price.gas_type }
    assert_redirected_to gas_price_path(assigns(:gas_price))
  end

  test "should destroy gas_price" do
    assert_difference('GasPrice.count', -1) do
      delete :destroy, id: @gas_price
    end

    assert_redirected_to gas_prices_path
  end
end
