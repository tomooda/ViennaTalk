tests-code generation-patterns
testSeqEnumPatternEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'def  [x, y] = [1, 2] in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'SeqEnumPattern'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3