module Rubim
	class Bundle
		def initialize
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