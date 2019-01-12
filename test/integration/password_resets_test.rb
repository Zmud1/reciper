require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:validuser)
  end

 test 'fully working password reset' do 
   get new_password_reset_path
   assert_template 'password_resets/new'
   post password_resets_path, params: {password_reset: {email: ''}}
   assert_not flash.empty?
   assert_template 'password_resets/new'
   post password_resets_path, params: {password_reset: {email: @user.email}}
   assert_not_equal @user.reset_digest , @user.reload.reset_digest
   assert_equal 1, ActionMailer::Base.deliveries.size
   assert_not flash.empty?
   assert_redirected_to root_url
   user = assigns(:user)
   #Valid token, wrong email
   get edit_password_reset_path(user.reset_token,email: "")
   assert_redirected_to root_url
   #Wrong token, valid email
   get edit_password_reset_path("gfgf",email: user.email)
   assert_redirected_to root_url
   #User not activated
   user.update_attribute(:activated, false)
   get edit_password_reset_path(user.reset_token, email: user.email)
   assert_redirected_to root_url
   user.update_attribute(:activated, true)
   #Right email right token
   get edit_password_reset_path(user.reset_token,email: user.email)
   assert_template 'password_resets/edit'
   #--------------PASSWORD RESET / EDIT VIEW ------------------
   #
    # Invalid password & confirmation
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password:              "foobaz",
                            password_confirmation: "barquux" } }
    assert_select 'div#error_explanation'
    # Empty password
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password:              "",
                            password_confirmation: "" } }
    assert_select 'div#error_explanation'
    # Valid password & confirmation
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password:              "foobaz",
                            password_confirmation: "foobaz" } }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
    assert_nil user.reload.reset_digest
  
 end
 
end