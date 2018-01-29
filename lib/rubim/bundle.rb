module Rubim
	class Bundle
		def initialize(levels: {})
			@levels = levels
		end

		def get_templates(entry)
			@templates.select {|t| t.applicable? entry }
		end

		def templates
			@levels.collect {|name, level| level[:templates]}
		end

		def add(template)
			@templates << template
		end

		def load
			@levels.each{ |l| load_level(l) }
		end

	private

		def load_level(level)
			p level
			blocks_dirs = get_dirs(level)
			blocks_dirs.each do |block_dir|
			end
		end

		def get_dirs(dir)
			p Dir["#{dir}/"]
		end
	end
end