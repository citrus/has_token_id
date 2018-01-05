module HasTokenId
  module Concern

    def self.included(base)
      base.send(:extend,  ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        validates :token, presence: true, uniqueness: true
        before_validation :generate_token, on: :create, if: proc{|record| record.token.nil? }
      end
    end

    module ClassMethods

      # Default options as well as an overwrite point so you can assign different defaults to different models
      def default_token_options
        @default_token_options ||= begin
          options = HasTokenId.default_token_options
          options[:prefix] ||= self.name[0, 1]
          options
        end
      end

      # Generates a unique token based on the options
      def generate_unique_token
        record, options = true, @has_token_id_options
        conditions = {}
        while record
          token = [ options[:prefix], Digest::SHA1.hexdigest((Time.now.to_i * rand()).to_s)].compact.join[0...options[:length].to_i]
          conditions[options[:param_name].to_sym] = token
          record = self.where(conditions).first
        end
        token
      end

    end # ClassMethods

    module InstanceMethods

      # Returns the resource's token
      def to_param
        self.send(self.class.has_token_id_options[:param_name])
      end

      # Returns the first N digits of the resource's token
      # N = has_token_id_options[:short_token_length]
      def short_token
        max = self.class.has_token_id_options[:length]
        len = self.class.has_token_id_options[:short_token_length]
        to_param[0, len < max ? len : max]
      end

    private

      def generate_token
        self.token = self.class.generate_unique_token
      end

    end # InstanceMethods

  end # Concern

end # HasTokenId
