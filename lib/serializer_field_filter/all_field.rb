class SerializerFieldFilter
  class AllField
    include ResourceOptions

    def root_fields
    end

    def scope_of(resource_name)
      AllField.new
    end
  end
end
