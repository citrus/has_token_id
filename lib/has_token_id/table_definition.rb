require 'active_record/connection_adapters/abstract/schema_definitions'

module HasTokenId
  module TableDefinition
    
    def token(*args)
      options = args.extract_options!
      column(:token, :string, options)
    end
  
  end
end

ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, HasTokenId::TableDefinition)
