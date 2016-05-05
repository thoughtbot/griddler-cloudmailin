# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'griddler/cloudmailin/version'

Gem::Specification.new do |spec|
  spec.name          = "griddler-cloudmailin"
  spec.version       = Griddler::Cloudmailin::VERSION
  spec.authors       = [""]
  spec.email         = [""]
  spec.summary       = 'CloudMailin adapter for Griddler'
  spec.description   = 'Adapter to allow the use of CloudMailin Incoming Addresses with Griddler'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'rubocop', '~> 0.36'
  spec.add_development_dependency 'gem-release', '~> 0.7'

  spec.add_dependency "griddler"
  spec.add_dependency 'mime-types', '~> 2.99' # 3.0 depends on Ruby >= 2.0
end
