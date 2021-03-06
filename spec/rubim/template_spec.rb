require_relative '../../lib/rubim/template'

describe Rubim::Template do
	context '#applicable?' do
		it 'returns true if hash entry matched' do
			template = Rubim::Template.match({block: 'b'}) {}

			entry = Rubim::Entry.from_hash({block: 'b'})

			expect(template.applicable?(entry)).to be true
		end

		it 'returns false if hash entry not matched' do
			template = Rubim::Template.match({block: 'b2'}) {}

			entry = Rubim::Entry.from_hash({block: 'b'})

			expect(template.applicable?(entry)).to be false
		end

		it 'returns true if lambda matcher returns true' do
			template = Rubim::Template.match(-> (e){e.block == 'b'}) {}

			entry = Rubim::Entry.from_hash({block: 'b'})

			expect(template.applicable?(entry)).to be true
		end
	end

	context '#apply' do
		it 'change tag' do
			template = Rubim::Template.match({block: 'b'}) do
				set_tag { 'span' }
			end

			entry = Rubim::Entry.from_hash({block: 'b'})

			entry = template.apply(entry)

			expect(entry.tag).to eq 'span'
		end

		it 'change content' do
			template = Rubim::Template.match({block: 'b'}) do
				set_content do
					[
						{block: 'b2'}
					]
				end
			end

			entry = Rubim::Entry.from_hash({block: 'b'})

			entry = template.apply(entry)

			expect(entry.content).to eq [{block: 'b2'}]
		end

		it 'adds entry mix' do
			template = Rubim::Template.match({block: 'b'}) do
				add_mix do
					{block: 'b2'}
				end
			end

			entry = Rubim::Entry.from_hash({block: 'b'})

			entry = template.apply(entry)

			expect(entry.mix).to eq [{block: 'b2'}]
		end

		it 'adds array mix' do
			template = Rubim::Template.match({block: 'b'}) do
				add_mix do
					[{block: 'b2'}, {block: 'b3'}]
				end
			end

			entry = Rubim::Entry.from_hash({block: 'b'})

			entry = template.apply(entry)

			expect(entry.mix).to eq [{block: 'b2'}, {block: 'b3'}]
		end

		it 'add mods' do
			template = Rubim::Template.match({block: 'b'}) do
				add_mods do
					[
						{mod: 'value'}
					]
				end
			end

			entry = Rubim::Entry.from_hash({block: 'b'})

			entry = template.apply(entry)

			expect(entry).to eq Rubim::Entry.from_hash(block: 'b', mods: [{mod: 'value'}])
		end
	end
end