tests-code generation-expressions
testTuplePatternEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'def  mk_(x, y) = mk_(1, 2) in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'TuplePattern'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 3