require 'rubim/html_node'
require 'rubim/entry'
require 'rubim/array_utils'

module Rubim
	class HtmlTreeBuilder
		include ArrayUtils

		def initialize(class_builder = Rubim::ClassBuilder.new)
			@class_builder = class_builder
		end

		def build(bem_tree)
			one_or_array(bem_tree) do |entry|
				process_entry(entry)
			end
		end

	private
		def process_entry(entry)
			node = HtmlNode.new(entry.tag || :div, [], {}, []) #todo remove fucking magick

			process_node(entry, node)
			process_js(entry, node)
			node.children = get_children(entry) if entry.content
			node
		end

		def process_node(entry, node)
			base_class = @class_builder.build(entry.block, entry.elem)
			classes = [base_class]
			attributes = entry.attrs || {}
			if entry.elem
				classes.concat element_mods_classes(entry.block, entry.elem, entry.mods) if entry.mods
			else
				classes.concat block_mods_classes(entry.block, entry.mods) if entry.mods
			end
			node.classes.concat classes
			node.attributes.merge! attributes
		end

		def get_children(entry)
			content = one_or_array(entry.content) do |child|
				if child.is_a? String
					next child
				end
				process_entry(child)
			end
			return content if content.is_a? Array
			[content]
		end

		def block_mods_classes(block, mods)
			mods.map do |key, value|
				@class_builder.build_block_class(block, key, value)
			end
		end

		def element_mods_classes(block, elem, mods)
			mods.map do |key, value|
				@class_builder.build_elem_class(block, elem, key, value)
			end
		end

		def process_js(entry, node)
			node.classes.push @class_builder.js_class if entry.js
		end
	end
end