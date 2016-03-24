require 'test_helper'

class ThesControllerTest < ActionController::TestCase
  setup do
    @the = thes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:thes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create the" do
    assert_difference('The.count') do
      post :create, the: { name: @the.name }
    end

    assert_redirected_to the_path(assigns(:the))
  end

  test "should show the" do
    get :show, id: @the
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @the
    assert_response :success
  end

  test "should update the" do
    patch :update, id: @the, the: { name: @the.name }
    assert_redirected_to the_path(assigns(:the))
  end

  test "should destroy the" do
    assert_difference('The.count', -1) do
      delete :destroy, id: @the
    end

    assert_redirected_to thes_path
  end
end
