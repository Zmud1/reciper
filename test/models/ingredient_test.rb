require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  
  def setup
    @i1 = ingredients(:banana)
    @i2 = ingredients(:apple)
    @m = microposts(:most_recent)
  end
  
  test 'should be valid' do
    assert @i1.valid?
  end
  
  test 'should have name'do
    @i1.name = ''
    assert_not @i1.valid?
  end
  
  test 'should have unique name'do
    @i2.name = @i1.name
    assert_not @i2.valid?
  end
  
  test 'no duplicate ingredients in same micropost' do
    @m.ingredients = [@i1,@i2]
    assert @m.ingredients.include?(@i2)
    assert_raise (ActiveRecord::RecordNotUnique) {@m.ingredients << @i2}
  end
  
end
