module Dynamix

	class Brain

		def add_attribute(obj, attribute)
			obj.class.module_eval { eval("attr_accessor :#{attribute}") }
		end

		def attach(refObj, attribute, obj)
			add_attribute(refObj, attribute)
			eval("refObj.#{attribute} = obj")
		end
	end

end

