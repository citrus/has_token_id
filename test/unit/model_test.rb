require_relative '../test_helper'


# We'll test the test/dummy/app/item.rb model

class ModelTest < Test::Unit::TestCase
  
  def setup
    Item.destroy_all
  end
  
  should "respond to has_token" do
    assert Item.respond_to?(:has_token)
  end
  
  should "set it's token" do  
    @item = Item.new(:name => "Something")
    assert @item.valid?
    assert_not_nil @item.token
    assert @item.save
  end
  
  should "only set it's token once" do
    @item = Item.new(:name => "Something")
    assert @item.valid?
    token = @item.token
    assert_not_nil token
    @item.name = "Something else"
    assert @item.valid?
    assert_equal token, @item.token
  end
  
  context "with an existing item" do
    
    setup do
      @item = Item.create(:name => "Blue Cheese Burger")
    end
    
    should "find by token" do
      assert_equal @item, Item.find(@item.token)
    end
    
  end
        
end
