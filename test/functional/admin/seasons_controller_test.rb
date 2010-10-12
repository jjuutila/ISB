require 'test_helper'

class Admin::SeasonsControllerTest < ActionController::TestCase
  setup do
    @admin_season = admin_seasons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_seasons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_season" do
    assert_difference('Admin::Season.count') do
      post :create, :admin_season => @admin_season.attributes
    end

    assert_redirected_to admin_season_path(assigns(:admin_season))
  end

  test "should show admin_season" do
    get :show, :id => @admin_season.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_season.to_param
    assert_response :success
  end

  test "should update admin_season" do
    put :update, :id => @admin_season.to_param, :admin_season => @admin_season.attributes
    assert_redirected_to admin_season_path(assigns(:admin_season))
  end

  test "should destroy admin_season" do
    assert_difference('Admin::Season.count', -1) do
      delete :destroy, :id => @admin_season.to_param
    end

    assert_redirected_to admin_seasons_path
  end
end
