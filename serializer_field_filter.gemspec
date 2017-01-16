lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serializer_field_filter/version'

Gem::Specification.new do |spec|
  spec.name          = "serializer_field_filter"
  spec.version       = SerializerFieldFilter::VERSION
  spec.authors       = ["Franky"]
  spec.email         = ["zhanglinjie412@gmail.com"]
  spec.description   = %q{field filter for active_model_serializers}
  spec.summary       = %q{field filter for active_model_serializers}
  spec.homepage      = "https://github.com/zhanglinjie/serializer_field_filter"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'active_model_serializers'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
