module Rubim
	BEM_ENTRY_FIELDS = %i(block elem content tag)
	Entry = Struct.new(*BEM_ENTRY_FIELDS) do
		def self.from_hash(hash)
			fields = Rubim::BEM_ENTRY_FIELDS.map{ |field| hash[field] }
			return Rubim::Entry.new(*fields)
		end
	end
end