module Rubim
	module ArrayUtils
		def one_or_array(tree, &block)
			if tree.is_a? Array
				return tree.map &block
			else
				yield tree
			end
		end
	end
end