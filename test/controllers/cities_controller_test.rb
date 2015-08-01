require 'test_helper'

class CitiesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cities)
  end

end
