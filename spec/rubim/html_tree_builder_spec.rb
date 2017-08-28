

describe Rubim::HtmlTreeBuilder do
	let(:builder) { described_class.new }
	let(:class_builder) { Rubim::ClassBuilder.new }

	context '#build' do
		context 'root entry' do
			context 'entry classes' do
				it 'build block class' do
					entry = Rubim::Entry.from_hash(block: 'b1')

					result = builder.build(entry)

					expect(result.classes).to include class_builder.build('b1')
				end

				it 'build elem class' do
					entry = Rubim::Entry.from_hash(block: 'b1', elem: 'e1')

					result = builder.build(entry)

					expect(result.classes).to include class_builder.build('b1', 'e1')
				end

				it 'build mod class for block' do
					entry = Rubim::Entry.from_hash(block: 'b1', mods: {mod: :value})

					result = builder.build(entry)

					expect(result.classes).to include class_builder.build_block_class('b1', :mod, :value)
				end

				it 'build mod class for elem' do
					entry = Rubim::Entry.from_hash(block: 'b1', elem: 'e1', mods: {mod: :value})

					result = builder.build(entry)

					expect(result.classes).to include class_builder.build_elem_class('b1', 'e1', :mod, :value)
				end
			end

			it 'adds attributes from attrs' do
				entry = Rubim::Entry.from_hash(block: 'b1', attrs: {attr1: :value1})

				result = builder.build(entry)

				expect(result.attributes).to eq({attr1: :value1})
			end

			context 'js' do
				it 'adds js class if js is true' do
					entry = Rubim::Entry.from_hash(block: 'b1', js: true)

					result = builder.build(entry)

					expect(result.classes).to include 'js-bem'
				end

				it 'adds js class if js is hash' do
					entry = Rubim::Entry.from_hash(block: 'b1', js: {key: :value})

					result = builder.build(entry)

					expect(result.classes).to include 'js-bem'
				end
			end
		end
	end
end
