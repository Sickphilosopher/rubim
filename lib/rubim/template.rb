module Rubim
	COMMON_TEMPLATE_FIELDS = %i(tag content attrs)
	Template = Struct.new(*COMMON_TEMPLATE_FIELDS) do
		def set_tag(&block)
			self.tag = block
		end

		def set_mather(matcher, &block)
			p "match #{self.name}"
		end

		def add_attrs
			p "add_attrs #{self.name}"
		end

		def set_content(&block)
			#"p content"
			self.content = block
		end
	end
end