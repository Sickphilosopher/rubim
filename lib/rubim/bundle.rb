module Rubim
	class Bundle
		def initialize(levels: {})
			@levels = levels
			@templates = []
		end

		def get_templates(entry)
			@templates.select {|t| t.applicable? entry }
		end

		def add(template)
			@templates << template
		end
	end
end