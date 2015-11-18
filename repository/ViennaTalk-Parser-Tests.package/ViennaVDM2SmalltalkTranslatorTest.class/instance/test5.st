testing
test5
	self assert: (Compiler evaluate: (translator expression parse: 'let s = power {<a>, <b>, <c>} in card s')) equals: 8