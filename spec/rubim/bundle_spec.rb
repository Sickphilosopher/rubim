require 'fakefs/safe'
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

		it 'collect all templates from level', fakefs: true do
			FakeFS do
				module Blocks
				end
				Dir.mktmpdir do |tmp_dir|
					block = :body
					level = :level
					level_folder = File.join(tmp_dir, 'blocks', level.to_s)
					block_folder = File.join(level_folder, block.to_s)
					block_file = File.join(block_folder, block.to_s + '.bl')

					FileUtils.mkdir_p(block_folder)
					block_code = <<-BLOCK
						Rubim::Template.match({block: '#{block}'}) do
						end
					BLOCK
					File.write(block_file, block_code)

					level_module = Module.new
					Blocks.const_set(level.to_s.capitalize.to_sym, level_module)

					block_template = level_module.class_eval(block_code)
					level_module.const_set(block.to_s.capitalize.to_sym, block_template)

					bundle = Rubim::Bundle.new({
						levels: [
							level: level_folder
						]
					})

					bundle.load()

					templates = bundle.get_templates({block: block})
					expect(bundle.templates).to include block_template
				end
			end
		end
	end
end