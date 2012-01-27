require "test_helper"

class TableDefinitionTest < MiniTest::Should::TestCase
  
  setup do
    @migration = ActiveRecord::Migration.new
    @definition = ActiveRecord::ConnectionAdapters::TableDefinition.new(@migration)  
  end
  
  should "include token as a migration table definition" do
    assert @definition.respond_to?(:token)
  end
  
  should "token definition should be the same as a string column named token" do
    capture(:stdout) {
      assert_equal @definition.column(:token, :string), @definition.token
    }
  end
  
  should "token definition should include custom options" do
    capture(:stdout) {
      assert_equal @definition.column(:token, :string, :length => 8), @definition.token(:length => 8)
    }
  end
  
end
