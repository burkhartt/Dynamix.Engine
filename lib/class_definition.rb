require_relative "./dynamix/version"

module Dynamix
	class ClassDefinition
		def initialize(object_definition)
			@attributes = Array.new
			@references = Hash.new
			@name = object_definition["name"]
			attributes = object_definition.has_key?("attributes") ? object_definition["attributes"] : Array.new
			references = object_definition.has_key?("references") ? object_definition["references"] : Array.new
			attributes.each do |attribute|
				add_attribute(attribute)
			end

			references.each do |reference|
				reference_attribute_name = reference["name"]
				reference_schemas = reference["schema"]
				reference_schemas.each do |reference_schema|
					reference_class_definition = ClassDefinition.new(reference_schema)
					add_reference(reference_attribute_name, reference_class_definition)
				end
			end			
		end

		def add_attribute(attribute)
			@attributes.push(attribute)
		end

		def add_reference(attribute, reference)
			if (!@references.has_key?(attribute))
				@references[attribute] = Array.new
			end

			@references[attribute].push(reference)
		end

		def get_name()
			@name
		end

		def get_attributes()
			@attributes
		end

		def get_reference(attribute)
			@references[attribute]
		end
	end
end
