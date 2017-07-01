tests-code generation-expressions
testTokenConstructorEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'mk_token(1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'TokenConstructor'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: (ViennaToken with: 1)