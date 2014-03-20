require_relative "./dynamix/version"
require_relative "blueprint_manager"
require 'json'

module Dynamix
	class ObjectArchitect
		def self.build()
			class_definitions = Dynamix::BlueprintManager.get_class_definitions()

			class_definitions.each do |class_name, class_definition|
				register_class(class_name, class_definition)
			end
		end

		private
		def self.register_class(class_name, class_definition)
			klass = Object.const_set(class_name.capitalize,Class.new)

			attributes = class_definition.get_attributes()
			references = class_definition.get_references()

			klass.class_eval do
		  		attr_accessor *attributes
		  		attr_accessor *references.keys

		  		define_method(:initialize) do |*values|
		    		attributes.each_with_index do |attribute,i|
		      			instance_variable_set("@"+attribute, values[i])
		    		end

		    		references.each do |attribute, reference_class_name|
		    			reference_object = Object.const_get(reference_class_name.capitalize).new()
		    			instance_variable_set("@"+attribute, reference_object)
		    		end
		  		end
			end
		end
	end
end