require_relative "./dynamix/version"
require_relative "class_definition"
require 'json'

module Dynamix
	class BlueprintManager
		@@class_definitions = Hash.new
		
		def self.add_blueprint(blueprint)
			object_definitions = JSON.parse(blueprint)
			object_definitions.each do |object_definition|
				class_definition = Dynamix::ClassDefinition.new(object_definition)
				class_name = class_definition.get_name()
				@@class_definitions[class_name] = class_definition
			end
		end

		def self.get_class_definition(class_name)
			@@class_definitions[class_name]
		end

		def self.get_class_definitions()
			@@class_definitions
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
