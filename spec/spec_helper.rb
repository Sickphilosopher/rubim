require 'bundler/setup'
require 'pp' #fix exception with FakeFS
require 'fakefs/spec_helpers'

Bundler.setup

require 'simplecov'
SimpleCov.start

require 'rubim'

RSpec.configure do |config|
	config.example_status_persistence_file_path = ".examples"
	config.include FakeFS::SpecHelpers, fakefs: true
end