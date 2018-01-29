# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rubim/version"

Gem::Specification.new do |spec|
	spec.name          = "rubim"
	spec.version       = Rubim::VERSION
	spec.authors       = ["Andrei Po"]
	spec.email         = ["sickphilosopher@gmail.com"]

	spec.summary       = %q{Bem template engine for ruby. Yes, BEM. Not BIM.}
	#spec.description   = %q{TODO: Write a longer description or delete this line.}
	#spec.homepage      = ""

	# Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
	# to allow pushing to a single host or delete this section to allow pushing to any host.
	if spec.respond_to?(:metadata)
		spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
	else
		raise "RubyGems 2.0 or newer is required to protect against " \
			"public gem pushes."
	end

	spec.files         = `git ls-files -z`.split("\x0").reject do |f|
		f.match(%r{^(test|spec|features)/})
	end
	spec.bindir        = "exe"
	spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
	spec.require_paths = ["lib"]

	spec.add_development_dependency "bundler", "~> 1.15"
	spec.add_development_dependency "rake", "~> 10.0"
	spec.add_development_dependency "rspec", "~> 3.6"
	spec.add_development_dependency "fakefs", "~> 0.13.0"
	spec.add_development_dependency "memory_profiler"
	spec.add_development_dependency "json"
	spec.add_development_dependency "rubocop"
	spec.add_development_dependency "simplecov"

	spec.add_dependency "dry-configurable", "~> 0.7"
end
