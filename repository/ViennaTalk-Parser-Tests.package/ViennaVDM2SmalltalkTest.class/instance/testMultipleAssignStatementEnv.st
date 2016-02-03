tests-code generation-statements
testMultipleAssignStatementEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'atomic(x:= y; y:= x)'.
	self deny: node isPetitFailure.
	self assert: node label = 'MultipleAssignStatement'.
	self
		assert: (Compiler evaluate: '|x y| x := 1. y := 2. ' , (ViennaVDM2Smalltalk new generate: node) , '. {x . y}')
		equals:
			{2.
			1}