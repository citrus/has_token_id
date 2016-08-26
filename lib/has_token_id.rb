require 'digest/sha1'
require 'has_token_id/concern'
require 'has_token_id/finder_methods'
require 'has_token_id/table_definition'

module HasTokenId

  module ActiveRecordTie

    def has_token_id(options={})
      self.send(:include, HasTokenId::Concern)
      @has_token_id_options = HasTokenId.default_token_options.merge(options)
    end

    def has_token_id_options
      @has_token_id_options
    end

  end

  def self.default_token_options
    @default_token_options ||= {
      :prefix             => nil, # if nil use first letter of class name
      :length             => 24,
      :short_token_length => 8,
      :param_name         => 'token',
      :case_sensitive     => false
    }
  end

end

ActiveRecord::Base.send(:extend, HasTokenId::ActiveRecordTie)
ActiveRecord::Base.send(:extend, HasTokenId::FinderMethods)
