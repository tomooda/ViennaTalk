tests-statements
testReturnStatement
	self assert: (ViennaVDMGrammar new statement parse: 'return 1') equals: '1'