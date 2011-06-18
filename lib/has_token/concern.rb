module HasToken
  module Concern
  
    extend ActiveSupport::Concern

    included do
      validates :token, :presence => true
      before_validation :generate_token, :on => :create, :if => proc{|record| record.token.nil? }
    end

    module ClassMethods
      attr_accessor :has_token_options
      
      def default_token_options
        {
          :prefix     => nil, # if nil use first letter of class name 
          :length     => 16,
          :param_name => 'token'
        }
      end
      
      def generate_unique_token
        record, options = true, self.has_token_options
        conditions = {}
        while record
          token = [options[:prefix], Digest::SHA1.hexdigest((Time.now.to_i * rand()).to_s)[1...options[:length].to_i]].join
          conditions[options[:param_name].to_sym] = token
          record = self.where(conditions).first
        end
        token
      end
      
      def is_token?(arg)
        arg.to_s.match(/[A-Z]{1}[0-9]+/) != nil
      end    
      
      def find(*args)
        if args[0].length == has_token_options[:length] && args[0][0] == has_token_options[:prefix]
          record = find_by_token(args[0]) rescue nil
        end
        record || __find__(*args)
      end
            
    end # ClassMethods
    
    module InstanceMethods
  
      def to_param 
        self.send(self.class.has_token_options[:param_name])
      end
    
      private      
        
        def generate_token
          self.token = self.class.generate_unique_token
        end
        
    end # InstanceMethods    

  end # Concern
  
end # HasToken
