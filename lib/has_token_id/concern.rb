module HasTokenId
  module Concern
  
    extend ActiveSupport::Concern

    included do
      validates :token, :presence => true, :uniqueness => true
      before_validation :generate_token, :on => :create, :if => proc{|record| record.token.nil? }
    end

    module ClassMethods
      attr_accessor :has_token_id_options
      
      # Default options as well as an overwrite point so you can assign different defaults to different models
      def default_token_options
        @default_token_options ||= HasTokenId.default_token_options.merge(:prefix => self.to_s[0])
      end
      
      # Generates a unique token based on the options
      def generate_unique_token
        record, options = true, self.has_token_id_options
        conditions = {}
        len = options[:length].to_i - options[:prefix].length
        while record
          token = [options[:prefix], Digest::SHA1.hexdigest((Time.now.to_i * rand()).to_s)[1..len]].compact.join
          conditions[options[:param_name].to_sym] = token
          record = self.where(conditions).first
        end
        token
      end
      
      # Find by token if the first param looks like a token, otherwise use super 
      def find(*args)
        if args[0].is_a?(String) && args[0].length == has_token_id_options[:length] && args[0][0] == has_token_id_options[:prefix]
          record = find_by_token(args[0]) rescue nil
        end
        record || super(*args)
      end
            
    end # ClassMethods
    
    module InstanceMethods
  
      def to_param 
        self.send(self.class.has_token_id_options[:param_name])
      end
    
      private      
        
        def generate_token
          self.token = self.class.generate_unique_token
        end
        
    end # InstanceMethods    

  end # Concern
  
end # HasTokenId
