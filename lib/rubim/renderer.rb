require 'rubim/array_utils'
require 'rubim/class_builder'

module Rubim
	class Renderer
		include ArrayUtils
		# List of attributes that get special treatment when rendering.
		#
		# @since 0.2.5
		# @api private
		#
		# @see http://www.w3.org/html/wg/drafts/html/master/infrastructure.html#boolean-attribute
		BOOLEAN_ATTRIBUTES = %w(
			allowfullscreen
			async
			autobuffer
			autofocus
			autoplay
			checked
			compact
			controls
			declare
			default
			defaultchecked
			defaultmuted
			defaultselected
			defer
			disabled
			draggable
			enabled
			formnovalidate
			hidden
			indeterminate
			inert
			ismap
			itemscope
			loop
			multiple
			muted
			nohref
			noresize
			noshade
			novalidate
			nowrap
			open
			pauseonexit
			pubdate
			readonly
			required
			reversed
			scoped
			seamless
			selected
			sortable
			spellcheck
			translate
			truespeed
			typemustmatch
			visible
		).freeze

		ATTRIBUTES_SEPARATOR = ' '.freeze

		def initialize()
			@standard_tag = 'div'
			#@class_builder = class_builder
		end

		def render(input)
			one_or_array(input) do |entry|
				process_entry(entry)
			end
		end

private
		def process_entry(entry)
			#classes = get_classes(entry)
			attributes = {}
			attributes[:class] = entry.classes.join(' ') if entry.classes.length > 0
			tag = entry.tag || @standard_tag
			render_node(tag, attributes)
		end

		def render_node(tag, attributes)
			tag ||= @standard_tag
			%(<#{tag}#{attributes_string(attributes)}></#{tag}>)
		end

		def get_classes(entry)
			classes = []
			if entry.block
				base_class = @class_builder.build(entry.block, entry.elem)
				classes << base_class
			end
			classes
		end

		def attributes_string(attrs)
			result = ''

			attrs.each do |attribute_name, value|
				if boolean_attribute?(attribute_name)
					result << boolean_attribute(attribute_name, value) if value
				else
					result << attribute(attribute_name, value)
				end
			end

			result
		end

		# @api private
		def boolean_attribute?(attribute_name)
			BOOLEAN_ATTRIBUTES.include?(attribute_name.to_s)
		end

		# Do not render boolean attributes when their value is _false_.
		# @api private
		def boolean_attribute(attribute_name, _value)
			%(#{ATTRIBUTES_SEPARATOR}#{attribute_name}='#{attribute_name}')
		end

		# @api private
		def attribute(attribute_name, value)
			%(#{ATTRIBUTES_SEPARATOR}#{attribute_name}='#{value}')
		end
	end
end