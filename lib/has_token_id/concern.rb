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
        return @default_token_options if @default_token_options
        @default_token_options = HasTokenId.default_token_options
        @default_token_options[:prefix] ||= self.to_s[0]
        @default_token_options
      end
      
      # Generates a unique token based on the options
      def generate_unique_token
        record, options = true, self.has_token_id_options
        conditions = {}
        while record
          token = [ options[:prefix], Digest::SHA1.hexdigest((Time.now.to_i * rand()).to_s)].compact.join[0...options[:length].to_i]
          conditions[options[:param_name].to_sym] = token
          record = self.where(conditions).first
        end
        token
      end
      
      # Find by token ensuring case sensitivity
      def find_by_case_sensitive_token(token)
        where("#{token_with_table_name} = ?", token).first
      end
      
      # Find by token regardless of case
      def find_by_case_insensitive_token(token)
        where("lower(#{token_with_table_name}) = ?", token.downcase).first
      end
      
      # Find by token
      def find_by_token(token)
        send(has_token_id_options[:case_sensitive] ? :find_by_case_sensitive_token : :find_by_case_insensitive_token, token)
      end
      
      # Find by token if the first param looks like a token, otherwise use super 
      def find(*args)
        if args[0].is_a?(String) && args[0].length == has_token_id_options[:length]
          record = find_by_token(args[0])
        end
        record || super(*args)
      end
      
      private
      
        def token_with_table_name
          [ table_name, has_token_id_options[:param_name] ].join(".")
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
