require "test_helper"

class HasTokenIdIdTest < MiniTest::Should::TestCase

  should "have version" do
    assert_equal String, HasTokenId::VERSION.class
  end

  should "have has_token_id method" do
    assert ActiveRecord::Base.respond_to?(:has_token_id)
  end

end
