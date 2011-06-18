require 'digest/sha1'
require 'has_token_id/concern'
require 'has_token_id/table_definition'

module HasTokenId

  def self.included(base)
    
    ActiveRecord::FinderMethods.send(:alias_method, :__find__, :find)
    
    base.instance_eval do
      
      def has_token_id(options={})
        self.send(:include, HasTokenId::Concern)
        self.has_token_id_options = self.default_token_options.merge(options)
      end
            
    end
        
  end
  
  def self.default_token_options
    {
      :prefix     => nil, # if nil use first letter of class name 
      :length     => 24,
      :param_name => 'token'
    }
  end
  
end # Has Token

ActiveRecord::Base.send(:include, HasTokenId) # unless ActiveRecord::Base.methods.include?(:has_token_id)
