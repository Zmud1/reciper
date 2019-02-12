require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user=User.new(name:"Example User", email: "user@example.com", password:"foobar", password_confirmation: "foobar" )
    @micropost = microposts(:most_recent)
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end
  
    test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert @user.invalid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert @user.invalid?
  end
  
test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
   test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert @user.invalid?, "#{invalid_address.inspect} should be invalid"
    end
  end
    test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email=@user.email
    @user.save
    assert_not duplicate_user.valid?
  end

 test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert @user.invalid?
  end
  
test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert @user.invalid?
  end
  
   test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test " should follow and unfollow user" do
    user1 = users(:validuser2)
    user2 = users(:validuser4)
    assert_not user1.following?(user2)
    user1.follow(user2)
    assert user1.following?(user2)
    assert user2.followers.include?(user1)
    user1.unfollow(user2)
    assert_not user1.following?(user2)
  end
  
   test "feed should have the right posts" do
    user = users(:validuser)
    user2  = users(:validuser2)
    user3    = users(:validuser3)
    # Posts from followed user
    user2.microposts.each do |post_following|
      assert user.feed.include?(post_following)
    end
    # Posts from self
    user.microposts.each do |post_self|
      assert user.feed.include?(post_self)
    end
    # Posts from unfollowed user
    user2.microposts.each do |post_unfollowed|
      assert_not user3.feed.include?(post_unfollowed)
    end
  end 
end