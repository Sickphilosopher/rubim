def block(name, &block)
	template = BlockTemplate.new(name)
	template.instance_eval(&block)
	BLOCK_TEMPLATES[name] = template
end