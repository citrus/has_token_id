# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
#require 'spork'

#Spork.prefork do
  
  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  require "rails/test_help"
  require "shoulda"
  require "sqlite3"
  
  Rails.backtrace_cleaner.remove_silencers!
  
#end

#Spork.each_run do
  
  #Dir[File.expand_path("../../lib/has_token_id/*.rb", __FILE__)].map{|f| load f }
  
#end
