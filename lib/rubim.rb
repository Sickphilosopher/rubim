require 'dry-configurable'

require 'rubim/version'
require 'rubim/template'
require 'rubim/entry_tree_builder'
require 'rubim/renderer'
require 'rubim/html_tree_builder'
require 'rubim/bundle'


module Rubim
	extend Dry::Configurable

	setting :bundles, [main: Bundle.new]
end
