require 'test_helper'

class Admin::TeamStandindsControllerTest < ActionController::TestCase
  setup do
    @admin_team_standind = admin_team_standinds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_team_standinds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_team_standind" do
    assert_difference('Admin::TeamStandind.count') do
      post :create, :admin_team_standind => @admin_team_standind.attributes
    end

    assert_redirected_to admin_team_standind_path(assigns(:admin_team_standind))
  end

  test "should show admin_team_standind" do
    get :show, :id => @admin_team_standind.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_team_standind.to_param
    assert_response :success
  end

  test "should update admin_team_standind" do
    put :update, :id => @admin_team_standind.to_param, :admin_team_standind => @admin_team_standind.attributes
    assert_redirected_to admin_team_standind_path(assigns(:admin_team_standind))
  end

  test "should destroy admin_team_standind" do
    assert_difference('Admin::TeamStandind.count', -1) do
      delete :destroy, :id => @admin_team_standind.to_param
    end

    assert_redirected_to admin_team_standinds_path
  end
end
