require 'test_helper'

class CityUsersControllerTest < ActionController::TestCase
  setup do
    @city_user = city_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:city_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create city_user" do
    assert_difference('CityUser.count') do
      post :create, city_user: {  }
    end

    assert_redirected_to city_user_path(assigns(:city_user))
  end

  test "should show city_user" do
    get :show, id: @city_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @city_user
    assert_response :success
  end

  test "should update city_user" do
    patch :update, id: @city_user, city_user: {  }
    assert_redirected_to city_user_path(assigns(:city_user))
  end

  test "should destroy city_user" do
    assert_difference('CityUser.count', -1) do
      delete :destroy, id: @city_user
    end

    assert_redirected_to city_users_path
  end
end
