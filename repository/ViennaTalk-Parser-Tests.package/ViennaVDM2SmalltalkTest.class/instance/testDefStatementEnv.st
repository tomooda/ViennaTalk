tests-code generation-statements
testDefStatementEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'def x : nat = 1; y : nat = x + 1 in a := x + y'.
	self deny: node isPetitFailure.
	self assert: node label = 'DefStatement'.
	self assert: (Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node env: Dictionary new) , '.a') equals: 3