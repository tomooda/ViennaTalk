tests-code generation-statements
testAssignStatementEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'x := 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'AssignStatement'.
	self assert: (Compiler evaluate: '|x|' , (ViennaVDM2SmalltalkScript new generate: node) , '. x') equals: 1