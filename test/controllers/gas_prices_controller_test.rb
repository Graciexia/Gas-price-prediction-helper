require 'test_helper'

class GasPricesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gas_prices)
  end

end
