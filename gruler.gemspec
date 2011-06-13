# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gruler/version"

Gem::Specification.new do |s|
  s.name        = "gruler"
  s.version     = Gruler::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["David Parry"]
  s.email       = ["david.parry@suranyami.com"]
  s.homepage    = ""
  s.summary     = %q{Game Rules engine}
  s.description = %q{EventMachine-based rules engine for games where the rules respond to events.}

  s.rubyforge_project = "gruler"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
