tests-code generation-statements
testLetBeStatementEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'let x in set {1,2} be st x mod 2 = 0 in a := x + 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'LetBeStatement'.
	self
		assert: (Compiler evaluate: '|a|' , (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new) , '. a')
		equals: 3