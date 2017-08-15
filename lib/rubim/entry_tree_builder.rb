require 'rubim/entry'
require 'rubim/context'
require 'rubim/bundle'
require 'rubim/exceptions'

module Rubim
	class EntryTreeBuilder
		def initialize(bundle = Rubim::Bundle.new)
			@bundle = bundle
		end

		def build(hash)
			context = Rubim::Context.new
			process_tree(hash, context)
		end

	private

		def process_any(entry, context)
			templates = @bundle.get_templates(entry)

			context.content = entry.content
			context.tag = entry.tag

			templates.each do |template|
				template.apply(entry)
			end

			if entry.content.is_a?(Array) || entry.content.is_a?(Hash)
				entry.content = process_tree(entry.content, context, entry.block)
			end

			entry.mix = process_tree(entry.mix, context, context.parent_block) if entry.mix

			entry
		end

		def process_block(entry, context)
			process_any(entry, context)
		end

		def process_elem(entry, context)
			raise Rubim::NoBlockException, 'Context should contains block for element' unless context.parent_block
			entry.block = context.parent_block
			process_any(entry, context)
		end

		def process_entry(entry, context, parent_block)
			context.parent_block = parent_block
			return process_elem(entry, context) if is_elem(entry)
			return process_block(entry, context) if is_block(entry)
			entry
		end


		def one_or_array(tree, &block)
			if tree.is_a? Array
				return tree.map &block
			else
				yield tree
			end
		end

		def process_tree(tree, context, parent_block = nil)
			one_or_array(tree) do |element|
				entry = Rubim::Entry.from_hash(element)
				process_entry(entry, context, parent_block)
			end
		end

		def is_elem(rson)
			!!rson.elem
		end

		def is_block(rson)
			!!rson.block
		end
	end
end