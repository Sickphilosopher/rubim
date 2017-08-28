module Rubim
	class ClassBuilder
		def initialize(elem_delim = '__', mod_delim = '--', value_delim = '_', js_class='js-bem')
			@mod_delim = mod_delim
			@elem_delim = elem_delim
			@value_delim = value_delim
			@js_class = js_class
		end

		def js_class
			@js_class
		end

		def build(block, elem = nil)
			if (!elem)
				return block
			else
				return block + @elem_delim + elem
			end
		end

		def build_mod_postfix(mod_name, mod_val)
			res = %(#{@mod_delim}#{mod_name})
			res.concat %(#{@value_delim}#{mod_val}) if mod_val != true
			res
		end

		def build_block_class(block, mod_name = nil, mod_val = nil)
			res = block
			res += build_mod_postfix(mod_name, mod_val) if mod_val
			return res
		end

		def build_elem_class(block, name, mod_name, mod_val)
			build_block_class(block) + @elem_delim + name + build_mod_postfix(mod_name, mod_val)
		end

		def split(key)
			return key.split(@elem_delim, 2)
		end
	end
end