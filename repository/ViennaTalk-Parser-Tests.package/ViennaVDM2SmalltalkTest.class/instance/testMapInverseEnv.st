tests-code generation-expressions
testMapInverseEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'inverse {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapInverse'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(#one -> 1).
			(#two -> 2).
			(#three -> 3)} asDictionary