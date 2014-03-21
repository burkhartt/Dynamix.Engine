require_relative "./dynamix/version"
require_relative "class_definition"
require 'json'

module Dynamix
	class Architect
		@@class_definitions = Hash.new
		
		def self.give_blueprints(blueprint)
			object_definitions = JSON.parse(blueprint)
			object_definitions.each do |object_definition|
				class_definition = Dynamix::ClassDefinition.new(object_definition)
				class_name = class_definition.get_name()
				@@class_definitions[class_name] = class_definition
			end
		end

		def self.build()
			class_definitions = get_class_definitions()

			class_definitions.each do |class_name, class_definition|
				register_class(class_name, class_definition)
			end
		end

		private
		def self.register_class(class_name, class_definition)
			class_name = class_name.capitalize
		
			klass = Object.const_set(class_name,Class.new)

			attributes = class_definition.get_attributes()
			references = class_definition.get_references()

			klass.class_eval do
		  		attr_accessor *attributes
		  		attr_accessor *references.keys

		  		define_method(:initialize) do |*values|
		    		attributes.each_with_index do |attribute,i|
		      			instance_variable_set("@"+attribute, values[i])
		    		end
		  		end
			end
		end

		def self.get_class_definition(class_name)
			@@class_definitions[class_name]
		end

		def self.get_class_definitions()
			@@class_definitions
		end
	end

end
