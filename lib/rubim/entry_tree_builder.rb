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

		def get_template(entry)
			@bundle.get_template(entry)
		end

		def process_any(entry, context)
			template = get_template(entry)

			context.content = entry.content
			context.tag = entry.tag

			if template && template.content
				entry.content = context.instance_eval(&template.content)
			end

			if template && template.tag
				entry.tag = context.instance_eval(&template.tag)
			end

			if entry.content.is_a?(Array) || entry.content.is_a?(Hash)
				entry.content = process_tree(entry.content, context)
			end
			entry
		end

		def process_block(entry, context)
			context.block = entry.block
			process_any(entry,context)
		end

		def process_elem(entry, context)
			raise Rubim::NoBlockException, 'Context should contains block for element' unless context.block
			entry.block = context.block
			process_any(entry, context)
		end

		def process_entry(entry, context)
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

		def process_tree(tree, context)
			one_or_array(tree) do |element|
				entry = Rubim::Entry.from_hash(element)
				process_entry(entry, context)
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