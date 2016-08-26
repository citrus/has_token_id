require "test_helper"

class HasTokenIdIdTest < MiniTest::Should::TestCase

  should "have version" do
    assert_equal String, HasTokenId::VERSION.class
  end

  should "have has_token_id method" do
    assert ActiveRecord::Base.respond_to?(:has_token_id)
  end

  context "#has_token_id_options" do

    should "always return a hash" do
      assert ActiveRecord::Base.send(:has_token_id_options).is_a?(Hash)
    end

    should "default to global defaults" do
      assert_equal HasTokenId.default_token_options, ActiveRecord::Base.send(:has_token_id_options)
    end

  end

end
