require_relative '../../lib/rubim/template'

describe 'entry tree template' do
	let(:bundle) {Rubim::Bundle.new}
	let(:builder) {Rubim::EntryTreeBuilder.new(bundle)}
	it 'use content from template' do
		template = Rubim::Template.match({block: 'b'}) do
			set_content do
				{
					block: 'b2',
					content: self.content
				}
			end
		end
		bundle.add(template)

		result = builder.build({block: 'b', content: 'test-content'})

		expect(result).to eq Rubim::Entry.from_hash({block: 'b', content: Rubim::Entry.from_hash({block: 'b2', content: 'test-content'})})
	end

	it 'use build large template' do
		require 'memory_profiler'
		require 'pp'
		require 'json'
		require 'benchmark'

		template = Rubim::Template.match({block: 'ad'}) do
			set_content do
				{
					block: 'test-block',
					content: self.content
				}
			end
		end
		bundle.add(template)

		input = JSON.parse(File.read(__dir__+'/bemjson.json'), symbolize_names: true)
		n = 50

		pages = []
		Benchmark.bm(5) do |x|
			x.report('building') do
				n.times do
					pages << builder.build(input)
				end
			end
		end

		pages = []
		report = MemoryProfiler.report do
			n.times do
				pages << builder.build(input)
			end
		end
		report.pretty_print
	end

end