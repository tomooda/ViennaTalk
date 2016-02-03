tests-code generation-expressions
testTupleSelectEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'mk_(4, 5, 6).#2'.
	self deny: node isPetitFailure.
	self assert: node label = 'TupleSelect'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 5