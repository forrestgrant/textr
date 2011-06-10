# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "textr/version"

Gem::Specification.new do |s|
  s.name        = "textr"
  s.version     = Textr::VERSION
  s.authors     = ["Forrest Grant"]
  s.email       = ["forrest@forrestgrant.com"]
  s.homepage    = "https://github.com/forrestgrant/textr"
  s.summary     = %q{Simple gem for sending SMS}
  s.description = %q{Send SMS either via `phone` column in class, or by calling Textr directly}

  s.rubyforge_project = "textr"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency 'pony'
  s.add_dependency 'rake', '0.8.7'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'activerecord', '3.0.7'
end
