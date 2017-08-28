module Rubim
	BEM_ENTRY_FIELDS = %i(block elem content tag mix js mods attrs)
	Entry = Struct.new(*BEM_ENTRY_FIELDS, :opts) do
		def self.from_hash(hash)
			fields = Rubim::BEM_ENTRY_FIELDS.map{ |field| hash.delete(field)  }
			entry = Rubim::Entry.new(*fields)
			entry.opts = hash if hash.length > 0
			entry
		end
	end
end