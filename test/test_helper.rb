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

env = File.expand_path("../dummy/config/environment.rb",  __FILE__)
if File.exists?(env)
  require env
else
  raise LoadError, "Please create the dummy app before running tests. Try running `bundle exec dummier`"
end

require "rails/test_help"
require "minitest/autorun"
require "minitest/should"

Rails.backtrace_cleaner.remove_silencers!
