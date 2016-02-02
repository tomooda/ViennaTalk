tests-code generation-expressions
testApplyEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1|->2}(1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'Apply'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 2