require "test_helper"

# We'll test the test/dummy/app/item.rb model

class ConcernTest < MiniTest::Should::TestCase

  setup do
    # remove all items
    Item.destroy_all
    # reset to defaults
    Item.has_token_id_options.merge!(Item.default_token_options)
  end

  should "respond to has_token_id" do
    assert Item.respond_to?(:has_token_id)
  end

  should "set it's token" do
    @item = Item.new(:name => "Something")
    assert @item.valid?
    assert !@item.token.nil?
    assert @item.save
  end

  should "only set it's token once" do
    @item = Item.new(:name => "Something")
    assert @item.valid?
    token = @item.token
    assert !token.nil?
    @item.name = "Something else"
    assert @item.valid?
    assert_equal token, @item.token
  end

  should "join token with table name when searching for record" do
    assert_equal "items.token", Item.send(:token_with_table_name)
  end

  context "with an existing item" do

    setup do
      @item = Item.create(:name => "Blue Cheese Burger")
    end

    should "assume token prefix" do
      assert_equal "I", @item.token[0, 1]
    end

    should "have default options" do
      opts = { :prefix => "I", :length => 24, :short_token_length => 8, :param_name => "token", :case_sensitive => false }
      assert_equal opts, Item.has_token_id_options
    end

    should "have proper token length" do
      assert_equal Item.has_token_id_options[:length], @item.token.length
    end

    should "have token as to_param" do
      assert_equal @item.to_param, @item.token
    end

    should "have short token" do
      assert_equal @item.token[0, 8], @item.short_token
      assert_equal 8, @item.short_token.length
    end

    should "return max token size when short token length is set longer than token length" do
      Item.has_token_id_options.merge!(:short_token_length => 99)
      assert_equal @item.token[0..24], @item.short_token
      assert_equal 24, @item.short_token.length
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
       assert_match Regexp.new("^item-(.*)"), @item.token
     end

  end

end
