testing
test3
	self
		assert: (Compiler evaluate: (translator expression parse: '2 in set dom {1|->"one", 2|->"two", 3|->"three"}'))
		equals: true