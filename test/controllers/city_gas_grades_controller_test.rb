require 'test_helper'

class CityGasGradesControllerTest < ActionController::TestCase
  setup do
    @city_gas_grade = city_gas_grades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:city_gas_grades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create city_gas_grade" do
    assert_difference('CityGasGrade.count') do
      post :create, city_gas_grade: {  }
    end

    assert_redirected_to city_gas_grade_path(assigns(:city_gas_grade))
  end

  test "should show city_gas_grade" do
    get :show, id: @city_gas_grade
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @city_gas_grade
    assert_response :success
  end

  test "should update city_gas_grade" do
    patch :update, id: @city_gas_grade, city_gas_grade: {  }
    assert_redirected_to city_gas_grade_path(assigns(:city_gas_grade))
  end

  test "should destroy city_gas_grade" do
    assert_difference('CityGasGrade.count', -1) do
      delete :destroy, id: @city_gas_grade
    end

    assert_redirected_to city_gas_grades_path
  end
end
