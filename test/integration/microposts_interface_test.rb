require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  
  
  def setup
    @user = users(:validuser)
    @user2 = users(:validuser2)
    @ing1 = ingredients(:banana)
    @ing2 = ingredients(:apple)
  end
  
  test "whole microposts" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    #Invalid empy micropost
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: {micropost: {content: '', ingredient_ids: [@ing1.id,@ing2.id]}}
    end
    #Too long micropost
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: {micropost: {content: "a" * 141}}
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "This micropost really ties the room together"
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: content, ingredient_ids: [@ing1.id,@ing2.id] } }
    end
    follow_redirect!
    assert_template root_path
    assert Micropost.first.ingredients.include?(@ing1) && Micropost.first.ingredients.include?(@ing2)
    assert_match content, body
    #Delete link
    first_micropost = @user.microposts.paginate(page: 1).first 
    assert_select 'a[href=?]', "/microposts/#{first_micropost.id}", text: 'delete' 
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    #Try to delete other users micropost
    get user_path(@user2)
    assert_select 'li#micropost', count: @user2.microposts.paginate(page: 1).count 
    assert_select 'a', text: 'delete', count: 0
    delete micropost_path(@user2.microposts.first)
    assert_redirected_to root_url
  end
    
    
end