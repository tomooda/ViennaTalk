testing
test4
	self assert: (Compiler evaluate: (translator expression parse: '(lambda x:int&x+1)(2)')) equals: 3