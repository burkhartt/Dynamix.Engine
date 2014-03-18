module Dynamix

	class Customer

    def initialize
      @values = {}
    end

    def method_missing(meth, *args, &blk)
      if meth.to_s[-1] == '='
        @values[meth.to_s.gsub('=', '').to_sym] = args[0]
      else
        @values[meth]
      end
    end

	end

end
