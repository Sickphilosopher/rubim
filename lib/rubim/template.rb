module Rubim
	TEMPLATE_FIELDS = %i(match tag content attrs mixes mods)
	Template = Struct.new(*TEMPLATE_FIELDS) do
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

		def add_mix(&block)
			self.mixes ||= []
			self.mixes << block
		end

		def add_mods(&block)
			self.mods ||= []
			self.mods << block
		end

		def apply(entry)
			entry.tag = entry.instance_eval(&self.tag) if self.tag
			entry.content = entry.instance_eval(&self.content) if self.content
			if self.mixes
				entry.mix ||= []
				entry.mix = [entry.mix] if entry.mix.is_a? Hash
				self.mixes.each {|mix| entry.mix.push(entry.instance_eval(&mix))}
				entry.mix.flatten!
			end
			if self.mods
				entry.mods ||= []
				entry.mods = [entry.mods] if entry.mods.is_a? Hash
				self.mods.each {|mod| entry.mods.push(entry.instance_eval(&mod))}
				entry.mods.flatten!
			end
			#entry.tag = entry.instance_eval(&self.tag) if self.tag
			#entry.tag = entry.instance_eval(&self.tag) if self.tag
			entry
		end

		def applicable?(entry)
			if match.is_a? Hash
				match.each do |key, value|
					return false if entry[key] != value
				end
			return true
			elsif match.is_a? Proc
				return match.call(entry)
			end
			return false
		end

		def self.match(match, &block)
			template = self.new(match)
			template.instance_eval(&block)
			template
		end
	end
end