describe Rubim::Entry do
	bem_keys = %i(block elem content tag mix js mods)

	it 'has all bem-keys' do
		aggregate_failures do
			bem_keys.each do |key|
				entry = Rubim::Entry.new()
				entry[key] = 'test-value'
				expect(entry[key]).to eq 'test-value'
			end
		end
	end

	context '.from_hash' do
		it 'fils all bem-keys from hash' do
			hash = bem_keys.each.with_object({}) do |key, hash|
				hash[key] = key
			end

			entry = Rubim::Entry.from_hash(hash)

			aggregate_failures do
				bem_keys.each do |key|
					expect(entry[key]).to eq key
				end
			end
		end

		it 'move non-bem keys to opts' do
			hash = {opt1: 'test1', opt2: 'test2'}

			entry = Rubim::Entry.from_hash(hash)

			expect(entry.opts).to eq hash
		end

		it 'not move bem keys to opts' do
			hash = {opt1: 'test1', block: 'b'}

			entry = Rubim::Entry.from_hash(hash)

			expect(entry.opts).to eq({opt1: 'test1'})
		end
	end
end