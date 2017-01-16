$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'byebug'
require 'rspec'
require 'rails/all'
require 'active_model_serializers'

require 'simplecov'
SimpleCov.start

require 'serializer_field_filter'

ActiveModelSerializers.logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new('/dev/null'))

RSpec.configure do |config|
end
