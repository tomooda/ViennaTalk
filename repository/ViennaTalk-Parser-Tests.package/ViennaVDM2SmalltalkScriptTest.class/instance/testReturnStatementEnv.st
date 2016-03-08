tests-code generation-statements
testReturnStatementEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'return 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'ReturnStatement'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: 1