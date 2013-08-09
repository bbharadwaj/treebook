require 'test_helper'

class StatusTest < ActiveSupport::TestCase
	test "that the status requires content" do
		status = Status.new
		assert !status.save
		assert !status.errors[:content].empty?
	end
	test "that the status requires content that is atleast 2 characters" do
		status = Status.new
		status.content = "H"
		assert !status.save
		assert !status.errors[:content].empty?
	end
	test "that the status requires user id" do
		status = Status.new
		status.content = "Hello"

		assert !status.save
		assert !status.errors[:user_id].empty?
	end
end
