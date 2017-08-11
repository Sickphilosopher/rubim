require 'spec_helper'

describe Rubim::EntryTreeBuilder do
	let(:builder) {Rubim::EntryTreeBuilder.new}
	describe 'root entry' do
		it 'returns empty entry' do
			input = {}

			result = builder.build(input)

			expect(result).to eq Rubim::Entry.new()
		end

		it 'returns block entry' do
			input = {block: 'test'}

			result = builder.build(input)

			expect(result).to eq Rubim::Entry.new('test')
		end

		it 'returns proper tag' do
			input = {block: 'test', tag: 'span'}

			result = builder.build(input)

			expected = Rubim::Entry.new('test')
			expected.tag = 'span'

			expect(result).to eq expected
		end

		it 'returns entry with string content' do
			input = {block: 'test', content: 'test-content'}

			result = builder.build(input)

			expected = Rubim::Entry.new('test')
			expected.content = 'test-content'

			expect(result).to eq expected
		end

		it 'returns entry with entry content' do
			input = {block: 'b1', content: {block: 'b2'}}

			result = builder.build(input)

			expected = Rubim::Entry.new('b1')
			expected.content = Rubim::Entry.new('b2')

			expect(result).to eq expected
		end

		it 'returns entry with array content' do
			input = {block: 'b1', content: [{block: 'b2'}, {block: 'b3'}]}

			result = builder.build(input)

			expected = Rubim::Entry.new('b1')
			expected.content = [Rubim::Entry.new('b2'), Rubim::Entry.new('b3')]

			expect(result).to eq expected
		end

		describe 'elem' do
			it 'returns elem entry in block context' do
				input = {block: 'b', content: {elem: 'e'}}

				result = builder.build(input)

				expected = Rubim::Entry.new('b')
				expected.content = Rubim::Entry.from_hash({block: 'b', elem: 'e'})

				expect(result).to eq expected
			end

			it 'raise exception if elem entry without block context & without block' do
				input = {elem: 'e'}

				expect {
					result = builder.build(input)
				}.to raise_error Rubim::NoBlockException
			end
		end

		describe 'mix' do
			it 'mixes block entity' do
				input = {block: 'b', mix: {block: 'b2'}}

				result = builder.build(input)
				expected = Rubim::Entry.from_hash(block: 'b', mix: Rubim::Entry.from_hash(b: 'b2'))
				expect(result).to eq expected
			end
		end
	end

	describe 'root array' do
		it 'returns empty array' do
			input = []
			result = builder.build(input)
			expect(result).to eq []
		end

		it 'returns array with entries' do
			input = [{block: 'a'}, {block: 'b'}]

			result = builder.build(input)

			expect(result).to eq [Rubim::Entry.new('a'), Rubim::Entry.new('b')]
		end
	end
end