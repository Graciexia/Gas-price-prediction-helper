require 'test_helper'

class OilPricesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oil_prices)
  end

end
