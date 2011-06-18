require_relative '../test_helper'

# We'll test the test/dummy/app/item.rb model

class ModelTest < Test::Unit::TestCase
  
  def setup
    Item.destroy_all
    Item.has_token_id_options = HasTokenId.default_token_options
  end
  
  should "respond to has_token_id" do
    assert Item.respond_to?(:has_token_id)
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
    
    should "assume token prefix" do
      assert_equal "I", @item.token[0]
    end
    
    should "have default options" do
      opts = {:prefix => "I", :length => 16, :param_name => "token"}
      assert_equal opts, Item.has_token_id_options
    end
    
    should "have proper token length" do
      assert_equal Item.has_token_id_options[:length], @item.token.length
    end
    
    should "have token as to_param" do
      assert_equal @item.to_param, @item.token
    end
    
    should "find by token" do
      assert_equal @item, Item.find(@item.token)
    end
    
  end

  context "with a long token" do
     
     setup do
       Item.has_token_id_options[:length] = 40
       @item = Item.create(:name => "Bacon Cheese Burger")
     end
     
     should "have long token" do
       assert_equal 40, @item.token.length
     end
    
  end
  
  context "with long prefix" do
  
     setup do
       Item.has_token_id_options.update(:prefix => "item-", :length => 40)
       @item = Item.create(:name => "Bacon Cheese Burger")
     end
  
     should "account for longer prefixes" do    
       assert_equal 40, @item.token.length
       assert_match /^item-(.*)/, @item.token
     end
    
  end
        
end
