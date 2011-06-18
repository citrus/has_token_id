require 'active_record/connection_adapters/abstract/schema_definitions'

module HasToken
  module TableDefinition
    
    def token(*args)
      options = args.extract_options!
      column(:token, :string, options)
    end
  
  end
end

ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, HasToken::TableDefinition)
