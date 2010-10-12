require 'test_helper'

class Admin::SectionsControllerTest < ActionController::TestCase
  setup do
    @admin_section = admin_sections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_section" do
    assert_difference('Admin::Section.count') do
      post :create, :admin_section => @admin_section.attributes
    end

    assert_redirected_to admin_section_path(assigns(:admin_section))
  end

  test "should show admin_section" do
    get :show, :id => @admin_section.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_section.to_param
    assert_response :success
  end

  test "should update admin_section" do
    put :update, :id => @admin_section.to_param, :admin_section => @admin_section.attributes
    assert_redirected_to admin_section_path(assigns(:admin_section))
  end

  test "should destroy admin_section" do
    assert_difference('Admin::Section.count', -1) do
      delete :destroy, :id => @admin_section.to_param
    end

    assert_redirected_to admin_sections_path
  end
end
