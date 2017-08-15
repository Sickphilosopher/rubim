describe Rubim::Bundle do
	let(:bundle) {described_class.new}
	context '#get_templates' do
		it 'returns applicable templates' do
			template = double('template', applicable?: true)
			bundle.add template

			expect(bundle.get_templates(nil)).to eq [template]
		end

		it 'returns empty array if applicable templates not found' do
			template = double('template', applicable?: false)
			bundle.add template

			expect(bundle.get_templates(nil)).to eq []
		end
	end
end