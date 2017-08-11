class ClassBuilder
	def initialize(elem_delim = '__', mod_delim = '--', value_delim = '_')
		@mod_delim = mod_delim
		@elem_delim = elem_delim
		@value_delim = value_delim
	end

	def build(block, elem)
		if (!elem)
			return block
		else
			return block + @elem_delim + elem
		end
	end

	def build_mod_postfix(mod_name, mod_val)
		res = @mod_delim + mod_name
		res += @val_delim + mod_val if mod_val != true
		res
	end

	def build_block_class(name, mod_name, modVal)
		res = name
		res += this.build_mod_postfix(mod_name, mod_val) if (mod_val)
		return res
	end

	def build_elem_class(block, name, mod_name, mod_val)
		build_block_class(block) + @elem_delim + name + this.build_mod_postfix(mod_name, mod_val)
	end

	def split(key)
		return key.split(@elem_delim, 2)
	end
end