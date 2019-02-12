require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest

#RELATIONSHIPS
=begin
  one:
    follower: validuser
    followed: validuser2
    
  two:
    follower: validuser
    followed: validuser3
    
  three:
    follower: validuser
    followed: validuser4
    
  four:
    follower: validuser3
    followed: validuser
=end 
 
def setup
  @user = users(:validuser)
  log_in_as(@user)
end 

 test "following page" do
    get following_user_path(@user)
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "followers page" do
    get followers_user_path(@user)
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end


end
