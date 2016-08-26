# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "has_token_id/version"

Gem::Specification.new do |s|

  s.name        = "has_token_id"
  s.version     = HasTokenId::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "https://github.com/citrus/has_token_id"
  s.summary     = %q{Identifies your active records with a random token.}
  s.description = %q{Identifies your active records with a random token. For more information, please see the documentation.}
  s.license     = "New BSD"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features,lib/dummy_hooks}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('activerecord',  '~> 3')
  s.add_dependency('activesupport', '~> 3')

  s.add_development_dependency('rails',           '~> 3')
  s.add_development_dependency('dummier',         '~> 0.3')
  s.add_development_dependency('minitest',        '~> 2.0')
  s.add_development_dependency('minitest_should', '~> 0.3')
  s.add_development_dependency('sqlite3',         '~> 1.3')

end
