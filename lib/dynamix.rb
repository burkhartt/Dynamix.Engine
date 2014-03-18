require_relative "./dynamix/version"
require 'json'

module Dynamix
	class Brain
		def initialize(schema)
			@schema = JSON.parse(schema)
		end

		def add_attribute(class_name, attribute)
			@schema[class_name]["attributes"].push(attribute)
		end

		def attach(class_name, attribute_name, schema)
			add_attribute(class_name, attribute_name)
			schema_to_attach = JSON.parse(schema)

			schema_to_attach.each do |new_class_name, attributes|
				@schema[class_name][attribute_name] = schema_to_attach
			end
			puts @schema
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
