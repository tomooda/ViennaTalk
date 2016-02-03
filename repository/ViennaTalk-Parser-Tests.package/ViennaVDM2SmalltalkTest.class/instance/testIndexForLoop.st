tests-code generation-statements
testIndexForLoop
	| node |
	node := ViennaVDMParser new statement end parse: 'for i = 1 to 10 by 2 do x := x + i'.
	self deny: node isPetitFailure.
	self assert: node label = 'IndexForLoop'.
	self
		assert: (Compiler evaluate: '|x| x:= 0.' , (ViennaVDM2Smalltalk new generate: node) , '.x')
		equals: 1 + 3 + 5 + 7 + 9