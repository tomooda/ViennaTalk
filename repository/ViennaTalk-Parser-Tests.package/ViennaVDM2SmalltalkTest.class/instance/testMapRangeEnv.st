tests-code generation-expressions
testMapRangeEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'rng {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapRange'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{#one.
			#two.
			#three} asSet