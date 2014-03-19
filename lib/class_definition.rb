require_relative "./dynamix/version"

module Dynamix
	class ClassDefinition
		def initialize(name)
			@name = name
			@attributes = Set.new
			@references = Hash.new
		end

		def add_attribute(attribute)
			@attributes.add(attribute)
		end

		def add_reference(attribute, reference)
			if (!@references.has_key?(attribute))
				@references[attribute] = Set.new
			end

			@references[attribute].add(reference)
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
