require_relative "./dynamix/version"

module Dynamix
	class Customer

	end

	class Brain
		def add_attribute(obj, attribute)
			obj.class.module_eval { eval("attr_accessor :#{attribute}") }
		end

		def attach(refObj, attribute, obj)
			add_attribute(refObj, attribute)
			eval("refObj.#{attribute} = obj")
		end

		def create(objName)
			class_name = objName.capitalize
			Object.const_set(class_name, Class.new)
		end
	end

end
