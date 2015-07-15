require 'test_helper'

class GasGradesControllerTest < ActionController::TestCase
  setup do
    @gas_grade = gas_grades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gas_grades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gas_grade" do
    assert_difference('GasGrade.count') do
      post :create, gas_grade: {  }
    end

    assert_redirected_to gas_grade_path(assigns(:gas_grade))
  end

  test "should show gas_grade" do
    get :show, id: @gas_grade
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gas_grade
    assert_response :success
  end

  test "should update gas_grade" do
    patch :update, id: @gas_grade, gas_grade: {  }
    assert_redirected_to gas_grade_path(assigns(:gas_grade))
  end

  test "should destroy gas_grade" do
    assert_difference('GasGrade.count', -1) do
      delete :destroy, id: @gas_grade
    end

    assert_redirected_to gas_grades_path
  end
end
