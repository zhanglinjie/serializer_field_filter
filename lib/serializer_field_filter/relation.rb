class SerializerFieldFilter
  module Relation
    extend ActiveSupport::Concern
    included do
      [:has_many, :belongs_to, :has_one].each do |relation_method_name|
        class_eval <<-RUBY
          def self.#{relation_method_name}_with_filter(resource_name, serializer: nil)
            attribute resource_name
            resource_method_module = Module.new do
              define_method resource_name do
                filter = instance_options[:field_filter]&.scope_of(resource_name)
                resource_options = filter.resource_options.merge({
                  serializer: serializer,
                })
                resources = defined?(super) ? super() : object.send(resource_name)
                if "#{relation_method_name}" == "has_many"
                  resources.to_a.map do |resource|
                    serializer_for_resource(resource, resource_options) if resource.present?
                  end
                else
                  serializer_for_resource(resources, resource_options) if resources.present?
                end
              end
            end
            prepend resource_method_module
          end
        RUBY
      end

      private

      def serializer_for_resource(resource, resource_options)
        ActiveModelSerializers::SerializableResource.new(resource, resource_options).as_json
      end
    end
  end
end
