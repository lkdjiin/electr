# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'electr/version'

Gem::Specification.new do |spec|
  spec.name          = "electr"
  spec.version       = Electr::VERSION
  spec.authors       = ["lkdjiin"]
  spec.email         = ["xavier.nayrac@gmail.com"]
  spec.summary       = %q{Interactive tiny language for electronic formulas}
  spec.homepage      = "https://github.com/lkdjiin/electr"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coco"
end
