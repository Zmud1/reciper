require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  def setup
    @user = users(:validuser)
  end
  
  
  test "is everything in place?"do
  get user_path(@user.id)
  assert_template 'users/show'
  # Minus 2 because there are 2 additional microposts in microposts.yml
  assert_select "li#micropost", count: 30
  assert_select "a[href=?]", "/users/#{@user.id}?page=2", count: 2
  get "/users/#{@user.id}?page=2"
  assert_select "li#micropost", count: @user.microposts.count - 30
  
  end
end
