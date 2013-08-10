require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase

  test "should get show" do
    get :show, id: users(:brijesh).profile_name
    assert_response :success
    assert_template "profiles/show"
  end

  test "should get 404 when not found" do
    get :show, id: "doesn't exit"
    assert_response :not_found
  end

  test "variables are assigned on successful profile viewing" do
    get :show, id: users(:brijesh).profile_name
    assert assigns(:user)
    assert_not_empty assigns(:statuses)
  end

  test "only correct statuses of a user are shown" do
    get :show, id: users(:brijesh).profile_name
    assigns(:statuses).each do |status|
    	assert_equal users(:brijesh), status.user
    end
  end
end
