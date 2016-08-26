require "test_helper"

# We'll test the test/dummy/app/item.rb model

class FinderMethodsTest < MiniTest::Should::TestCase

  setup do
    # remove all items
    Item.destroy_all
    # reset to defaults
    Item.has_token_id_options.merge!(Item.default_token_options)
    @item = Item.create(:name => "Blue Cheese Burger")
  end

  should "find by using default find method" do
    assert_equal @item, Item.find(@item.token)
  end

  should "work with token finder method" do
    assert Item.find_by_token(@item.token)
  end

  should "return nil when token is nil" do
    assert_nil Item.find_by_token(nil)
  end

  should "work with !bang token finder method" do
    assert Item.find_by_token!(@item.token)
  end

  should "return nil from token finder method when record is not found" do
    assert_equal nil, Item.find_by_token("invalid")
  end

  should "raise activerecord not found from !bang token finder method when record is not found" do
    assert_raises ActiveRecord::RecordNotFound do
      Item.find_by_token!("invalid")
    end
  end

  context "when case sensitivity is disabled" do

    setup do
      Item.has_token_id_options[:case_sensitive] = false
    end

    should "find by token" do
      assert_equal @item, Item.find(@item.token)
      assert_equal @item, Item.find_by_token(@item.token)
      assert_equal @item, Item.find_by_token!(@item.token)
    end

    should "find by token even if it's all uppercase" do
      assert_equal @item, Item.find(@item.token.upcase)
      assert_equal @item, Item.find_by_token(@item.token.upcase)
      assert_equal @item, Item.find_by_token!(@item.token.upcase)
    end

    should "find by token even if it's all lowercase" do
      assert_equal @item, Item.find(@item.token.downcase)
      assert_equal @item, Item.find_by_token(@item.token.downcase)
      assert_equal @item, Item.find_by_token!(@item.token.downcase)
    end

  end

  context "when case sensitivity is enabled" do

    setup do
      Item.has_token_id_options[:case_sensitive] = true
    end

    should "find by token" do
      assert_equal @item, Item.find(@item.token)
      assert_equal @item, Item.find_by_token(@item.token)
      assert_equal @item, Item.find_by_token!(@item.token)
    end

    should "not find by token if it's all uppercase" do
      assert_raises ActiveRecord::RecordNotFound do
        Item.find(@item.token.upcase)
      end
      assert_equal nil, Item.find_by_token(@item.token.upcase)
      assert_raises ActiveRecord::RecordNotFound do
        Item.find_by_token!(@item.token.upcase)
      end
    end

    should "not find by token if it's all lowercase" do
      assert_raises ActiveRecord::RecordNotFound do
        Item.find(@item.token.downcase)
      end
      assert_equal nil, Item.find_by_token(@item.token.downcase)
      assert_raises ActiveRecord::RecordNotFound do
        assert Item.find_by_token!(@item.token.downcase)
      end
    end

  end
end
