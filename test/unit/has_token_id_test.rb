require "test_helper"

class HasTokenIdIdTest < MiniTest::Should::TestCase
  
  should "include HasTokenId" do
    assert ActiveRecord::Base.included_modules.include?(HasTokenId)
  end
  
  should "have has_token_id method" do
    assert ActiveRecord::Base.methods.include?(:has_token_id)
  end
    
end
