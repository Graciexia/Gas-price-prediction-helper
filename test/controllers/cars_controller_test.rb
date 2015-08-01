require 'test_helper'

class CarsControllerTest < ActionController::TestCase


  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cars)
  end


  test "should get edit" do
    get :edit, id: @car
    assert_response :success
  end


end
