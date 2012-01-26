ENV["RAILS_ENV"] = "test"

gem "minitest"

begin
  require "simplecov"
  SimpleCov.start do
    add_filter do |source_file|
      source_file.filename =~ /dummy/
    end
  end
rescue LoadError
end

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "minitest/autorun"
require "minitest/should"

Rails.backtrace_cleaner.remove_silencers!
