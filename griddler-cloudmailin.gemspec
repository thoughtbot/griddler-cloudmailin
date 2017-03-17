# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'griddler/cloudmailin/version'

Gem::Specification.new do |spec|
  spec.name          = 'griddler-cloudmailin'
  spec.version       = Griddler::Cloudmailin::VERSION
  spec.authors       = ['Dominic Sayers & Caleb Thompson']
  spec.email         = ['dominic@sayers.cc']
  spec.summary       = 'Griddler Plugin for cloudmailin'
  spec.description   = 'Griddler Plugin for cloudmailin email parsing service'
  spec.homepage      = 'https://github.com/thoughtbot/griddler-cloudmailin'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin\/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features|coverage)\/})
  spec.require_paths = ['lib']

  spec.add_dependency 'griddler'
end
