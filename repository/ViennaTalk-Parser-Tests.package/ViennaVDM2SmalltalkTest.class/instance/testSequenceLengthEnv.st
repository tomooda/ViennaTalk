tests-code generation-expressions
testSequenceLengthEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'len [4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceLength'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3