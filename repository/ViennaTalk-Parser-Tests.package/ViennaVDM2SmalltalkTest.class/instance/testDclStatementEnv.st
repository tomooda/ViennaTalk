tests-code generation-statements
testDclStatementEnv
	| node |
	node := ViennaVDMParser new statement end parse: '(dcl x:nat := 1, y:nat; y := 2; a := x + y)'.
	self deny: node isPetitFailure.
	self assert: node first label = 'DclStatement'.
	self assert: (Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node) , '. a') equals: 3