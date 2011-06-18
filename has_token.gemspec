# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "has_token/version"

Gem::Specification.new do |s|
  s.name        = "has_token"
  s.version     = HasToken::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "https://github.com/citrus/has_token"
  s.summary     = %q{Adds a random token to your rails model}
  #s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "has_token"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features,lib/dummy_hooks}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('activerecord',  '>= 3.0.0')
  s.add_dependency('activesupport', '>= 3.0.0')
  
  s.add_development_dependency('shoulda',        '>= 2.11.3')
  s.add_development_dependency('dummier',        '>= 0.1.1')
  s.add_development_dependency('sqlite3',        '>= 1.3.3')
  s.add_development_dependency('spork',          '>= 0.9.0.rc8')
  s.add_development_dependency('spork-testunit', '>= 0.0.5')
   
end
