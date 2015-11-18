testing
test6
	self assert: (Compiler evaluate: (translator expression parse: 'let inc:int->int inc(x)==x+1 in inc(2)')) equals: 3