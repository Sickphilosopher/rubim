

describe Rubim::HtmlNode do
	context '.from_bem_entry' do
		it 'build block class' do
			entry = Rubim::Entry.from_hash(block: 'b1')
			node = described_class.from_bem_entry(entry)
			expect(node.classes).to include 'b1'
		end
	end
end
