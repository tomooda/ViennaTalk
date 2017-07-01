tests-code generation-expressions
testSetIntersectionEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1,2,3} inter {2, 3, 4}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetIntersection'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{2.
			3} asSet