require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
	should belong_to(:user)
	should belong_to(:friend)

	test "that creating a friendship works without raising an exception" do
		assert UserFriendship.create user: users(:brijesh), friend: users(:neha)	
	end

	test "creating friendships on a user works with user id and friend id" do
		UserFriendship.create user_id: users(:brijesh).id, friend_id: users(:neha).id
		assert users(:brijesh).friends.include?(users(:neha))
		
	end
end
