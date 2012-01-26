ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "minitest/autorun"
require "minitest/should"
require "sqlite3"

Rails.backtrace_cleaner.remove_silencers!
