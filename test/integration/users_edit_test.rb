require 'test_helper'


class UsersEditTest < ActionDispatch::IntegrationTest

def setup
  @user = users(:validuser)
end 
  
  test 'unsuccesful edit' do 
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    
   patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
    assert_select 'div.alert', 'The form contains 4 errors.'
    
  end 

   test 'sucessful user edit ' do 
    log_in_as(@user) 
    get edit_user_path(@user)
    assert_template 'users/edit'
    
   patch user_path(@user), params: { user: { name:  "#{@user.name} 11" ,
                                              email: "#{@user.email}" ,
                                              password: '',            
                                              password_confirmation: '' } }
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    @user.reload
    assert_equal @user.name, 'Valid Name 11'
  end 
  
    test 'sucessful user edit with friendly forwarding ' do 
    get edit_user_path(@user)
    log_in_as(@user) 
    assert_redirected_to edit_user_url(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    
   patch user_path(@user), params: { user: { name:  "#{@user.name} 11" ,
                                              email: "#{@user.email}" ,
                                              password: '',            
                                              password_confirmation: '' } }
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    @user.reload
    assert_equal @user.name, 'Valid Name 11'
  end 
  
  
  
  
  
  
  
  
  
end
