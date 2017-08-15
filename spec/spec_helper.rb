require 'bundler/setup'
Bundler.setup

require 'simplecov'
SimpleCov.start

require 'rubim'

RSpec.configure do |config|
	config.example_status_persistence_file_path = ".examples"
end