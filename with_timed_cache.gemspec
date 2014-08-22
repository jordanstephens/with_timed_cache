# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'with_timed_cache/version'

Gem::Specification.new do |spec|
  spec.name          = "with_timed_cache"
  spec.version       = WithTimedCache::VERSION
  spec.authors       = ["Jordan Stephens"]
  spec.email         = ["iam@jordanstephens.net"]
  spec.description   = %q{A simple time based cache}
  spec.summary       = %q{Cache data to a local file for a defined amount of time}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_dependency "activesupport"
  spec.add_dependency "json"
end
