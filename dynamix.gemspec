# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dynamix/version', __FILE__)
require 'json'

Gem::Specification.new do |gem|
  gem.authors       = ["Tim Burkhart"]
  gem.email         = ["timmyb_84@hotmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "dynamix"
  gem.require_paths = ["lib"]
  gem.version       = Dynamix::VERSION
end
