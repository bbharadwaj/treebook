 require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
 	context "#new" do
 		context "when not logged in" do 
 			should "redirect to the login page" do
 				get :new
 				assert_response :redirect
 			end
 		end
 		context "when they are logged in" do
 			setup do
 				sign_in users(:brijesh)
 			end

 			should "get new page and return success" do
 				get :new
 				assert_response :success
 			end

 			should "set a flash error if the friend_id params is missing" do
 				get :new, {}
 				assert_equal "Friend required", flash[:error]
 			end
 			should "display the friend's name" do 
 				get :new, friend_id: users(:nam)
 				assert_match /#{users(:nam).full_name}/, response.body
 			end

 			should "assign a new user friendship" do
 				get :new, friend_id: users(:nam)
 				assert assigns(:user_friendship)
 			end

 			should "assign a new user friendship to check the right friend" do
 				get :new, friend_id: users(:nam)
 				assert_equal users(:nam), assigns(:user_friendship).friend
 			end
 			should "friendship has been created to the logged in user" do
 				get :new, friend_id: users(:nam)
 				assert_equal users(:brijesh), assigns(:user_friendship).user
 			end
 			should "return 404 if friend not found" do
 				get :new, friend_id: "invalid"
 				assert_response :not_found
 			end
 			should "ask if you really want to friend the user" do
 				get :new, friend_id: users(:nam)
 				assert_match /Do you really want to friend #{users(:nam).full_name}?/, response.body
 			end
 		end
	end

	context "#create" do 

		context "when not logged in" do
			should " redirect to the login page" do 
				get :new
				assert_response :redirect
				assert_redirected_to login_path
			end
		end

		context "when logged in" do
 			setup do
 				sign_in users(:brijesh)
 			end
		end

		context "with no friend_id" do
 			setup do
 				post :create
 			end

 			should "set up flash error message" do
 				assert !flash[:error].empty?
 			end
 			should "set redirect to root path" do
 				assert_redirected_to root_path
 			end
		end

		context "with valid friend_id" do
 			setup do
 				sign_in users(:brijesh)
 				post :create, user_friendship: {friend_id: users(:nam)}
 			end

 			should "set up flash error message" do
 				assert assigns(:friend)
 				assert_equal users(:nam), assigns(:friend)
 			end
 			should "set create a user friendship object" do
 				assert assigns(:user_friendship)
 				assert_equal users(:brijesh), assigns(:user_friendship).user
 				assert_equal users(:nam), assigns(:user_friendship).friend  
 			end
 			should "create a friendship" do 
 				assert users(:brijesh).friends.include?users(:nam)
 			end
 			should "should redirect to profile page of friend" do 
 				assert_response :redirect
 				assert_redirected_to profile_path(users(:nam))
 			end
 			should "set flash success message" do 
 				assert flash[:success]
 				assert_equal "You are now friends with #{users(:nam).full_name}", flash[:success]
 			end
		end

	end
end
 