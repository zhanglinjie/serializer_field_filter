require "active_model_serializers"
require "serializer_field_filter/version"
require "serializer_field_filter/resource_options"
require "serializer_field_filter/all_field"
require "serializer_field_filter/none_field"
require "serializer_field_filter/relation"

class SerializerFieldFilter
  include ResourceOptions

  attr_reader :fields

  def initialize(fields = [])
    @fields = fields
  end

  def self.init(fields = nil)
    fields.present? ? new(fields) : AllField.new
  end

  def root_fields
    return if fields.blank?
    fields.map { |field| field.split('.').first.to_sym }.uniq
  end

  def scope_of(resource_name)
    if fields.include?(resource_name.to_s)
      AllField.new
    else
      scope_fields = fields.select { |field| field.start_with?("#{resource_name}.") }
                           .map { |field| field.split('.', 2).last }
      scope_fields.present? ? SerializerFieldFilter.new(scope_fields) : NoneField.new
    end
  end
end
