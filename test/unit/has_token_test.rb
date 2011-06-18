require_relative '../test_helper'

class HasTokenTest < Test::Unit::TestCase
  
  def setup
    
  end
  
  should "include HasToken" do
    assert ActiveRecord::Base.included_modules.include?(HasToken)
  end
  
  should "have has_token method" do
    assert ActiveRecord::Base.methods.include?(:has_token)
  end
    
end
