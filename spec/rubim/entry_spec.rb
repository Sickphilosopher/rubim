describe Rubim::Entry do
	context '.from_hash' do
		it 'creates entry with all keys' do
			keys = %i(block elem content tag mix js mods)
			aggregate_failures do
				keys.each do |key|
					entry = Rubim::Entry.new()
					entry[key] = 'test-value'
					expect(entry[key]).to eq 'test-value'
				end
			end
		end
	end
end