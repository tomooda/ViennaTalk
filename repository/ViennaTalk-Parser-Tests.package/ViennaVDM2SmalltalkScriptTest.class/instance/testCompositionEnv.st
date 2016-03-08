tests-code generation-expressions
testCompositionEnv
	| node |
	node := ViennaVDMParser new expression end parse: '(lambda x:nat & x + 1) comp (lambda x:nat & x * 2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'Composition'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node) , ' value: 3') equals: 7