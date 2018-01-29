describe Rubim::Renderer do
	let(:renderer) { described_class.new }
	context '#render' do
		it 'render empty entry to empty div' do
			input = Rubim::Entry.new()

			result = renderer.render(input)

			expect(result).to eq '<div></div>'
		end

		it 'render block entry to empty div with class' do
			input = Rubim::Entry.from_hash(block: 'b1')

			result = renderer.render(input)

			expect(result).to eq '<div class=\'b1\'></div>'
		end

		it 'render elem entry to empty div with elem class' do
			input = Rubim::Entry.from_hash(block: 'b1', elem: 'e1')

			result = renderer.render(input)

			expect(result).to eq '<div class=\'b1__e1\'></div>'
		end

		it 'adds js class if js is not nil or false' do
			input = Rubim::Entry.from_hash(block: 'b1', js: true)

			result = renderer.render(input)

			expect(result).to eq '<div class=\'b1 js\'></div>'
		end
	end
end