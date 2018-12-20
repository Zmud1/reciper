require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:validuser)
    @user2 = users(:validuser2)
  end 
  
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    follow_redirect!
    assert_template 'sessions/new'
    assert_not flash.nil?
  end 
  
  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect user if he tried to update other's data" do
    log_in_as(@user)
   get edit_user_url(@user2)
    follow_redirect!
    assert_template 'static_pages/home'
    assert_not flash.nil?
  end 
  
end
