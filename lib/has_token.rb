require 'digest/sha1'
require 'has_token/concern'

module HasToken

  def self.included(base)
    
    ActiveRecord::FinderMethods.send(:alias_method, :__find__, :find)
    
    base.instance_eval do
      
      def has_token(options={})
        self.send(:include, HasToken::Concern)
        self.has_token_options = self.default_token_options.merge(options)
        self.has_token_options[:prefix] ||= self.class.to_s[0].upcase
      end
            
    end
        
  end
  
end # Has Token

ActiveRecord::Base.send(:include, HasToken) # unless ActiveRecord::Base.methods.include?(:has_token)
