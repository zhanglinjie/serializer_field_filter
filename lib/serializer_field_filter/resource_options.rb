class SerializerFieldFilter
  module ResourceOptions
    extend ActiveSupport::Concern
    included do
      def resource_options
        { fields: root_fields, field_filter: self }
      end
    end
  end
end
