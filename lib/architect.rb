require_relative "./dynamix/version"
require_relative "class_definition"
require 'json'

module Dynamix
	class Architect
		def initialize()
			@class_definitions = Hash.new
		end

		def add_schema(schema)
			object_definitions = JSON.parse(schema)
			object_definitions.each do |object_definition|
				name = object_definition["name"]
				attributes = object_definition.has_key?("attributes") ? object_definition["attributes"] : Array.new
				references = object_definition.has_key?("references") ? object_definition["references"] : Array.new

				class_definition = Dynamix::ClassDefinition.new(name)
				attributes.each do |attribute|
					class_definition.add_attribute(attribute)
				end

				references.each do |reference|
					reference_attribute_name = reference["name"]
					reference_schema = reference["schema"]
					reference_class_definition = create_class_definition(reference_schema)
					class_definition.add_reference(reference_attribute_name, reference_class_definition)
				end

				@class_definitions[name] = class_definition
			end
				puts @class_definitions["customer"].get_reference("parent").get_attributes()

		end

		def create_class_definition(schema)
			reference_class_definitions = Hash.new
			schema.each do |object_definition|
				name = object_definition["name"]
				attributes = object_definition.has_key?("attributes") ? object_definition["attributes"] : Array.new
				references = object_definition.has_key?("references") ? object_definition["references"] : Array.new

				class_definition = Dynamix::ClassDefinition.new(name)
				attributes.each do |attribute|
					class_definition.add_attribute(attribute)
				end

				references.each do |reference|
					reference_attribute_name = reference["name"]
					reference_schema = reference["schema"]
					reference_class_definition = create_class_definition(reference_schema.to_json)
					class_definition.add_reference(reference_attribute_name, reference_class_definition)
				end
				reference_class_definitions[name] = class_definition

			end

			return reference_class_definitions
		end

		def get_class_definitions()
			@class_definitions
		end

		

		def create(class_name)
			attributes = @schema[class_name]["attributes"]
			class_name = class_name.capitalize
			obj = Object.const_set(class_name, Class.new)
			attributes.each do |attribute|
				obj.class.module_eval { eval("attr_accessor :#{attribute}") }
			end
			return obj
		end
	end

end
