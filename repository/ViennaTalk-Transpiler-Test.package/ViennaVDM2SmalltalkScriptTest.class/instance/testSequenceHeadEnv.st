tests-code generation-expressions
testSequenceHeadEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'hd [4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceHead'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 4