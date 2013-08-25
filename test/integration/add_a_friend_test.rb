require 'test_helper'

class AddAFriendTest < ActionDispatch::IntegrationTest
	def sign_in_as(user, password)
		post login_path, user: {email: user.email, password: password}
	end

	test "that adding a friend works" do
		 sign_in_as users(:brijesh), "testing"
		 get "/user_friendships/new?friend_id=#{users(:nam).profile_name}"
		 assert_response :success
		 assert_difference "UserFreindship.count" do 
		 	post "/user_friendships", user_friendship: {friend_id: users(:nam).profile_name}
		 	assert_response :redirect
		 	assert_equal "You are now friends with #{users(:nam).full_name}", flash[:success]
		 end
	end
end
