class SerializerFieldFilter
  class NoneField
    include ResourceOptions

    def root_fields
      []
    end

    def scope_of(resource_name)
      NoneField.new
    end
  end
end
