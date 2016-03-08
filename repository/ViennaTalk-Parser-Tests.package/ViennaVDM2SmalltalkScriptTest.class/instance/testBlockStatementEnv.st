tests-code generation-statements
testBlockStatementEnv
	| node |
	node := ViennaVDMParser new statement end parse: '(dcl x:nat := 1, y:nat; y := 2; a := x + y)'.
	self deny: node isPetitFailure.
	self assert: node label = 'BlockStatement'.
	self assert: (Compiler evaluate: '|a|' , (ViennaVDM2SmalltalkScript new generate: node) , '. a') equals: 3