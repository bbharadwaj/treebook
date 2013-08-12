require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "status new - should be redirected when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "status new - should render new page when logged in" do
    sign_in users(:brijesh)
    get :new
    assert_response :success
  end

  test "status create - should be redirected when not logged in" do
    post :create, status: {content: "Helllo"}
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "status create - should create status when logged in as yourself only" do
    sign_in users(:brijesh)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content, user_id: users(:neha).id}
    end

    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:brijesh).id
  end

  test "should show status" do
    get :show, id: @status
    assert_response :success
  end

  test "status edit - should be redirected when not logged in" do
    get :edit, id: @status
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should get edit when logged in" do
    sign_in users(:brijesh)
    get :edit, id: @status
    assert_response :success
  end

  test "status update - should be redirected when not logged in" do
    patch :update, id: @status, status: {content: @status.content}
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end


  test "should update status for the current user when logged in" do
    sign_in users(:brijesh)
    patch :update, id: @status, status: {content: @status.content, user_id: users(:neha).id}
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:brijesh).id
  end

  test "should not update the status when nothing has changed" do
    sign_in users(:brijesh)
    patch :update, id: @status
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:brijesh).id
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end
