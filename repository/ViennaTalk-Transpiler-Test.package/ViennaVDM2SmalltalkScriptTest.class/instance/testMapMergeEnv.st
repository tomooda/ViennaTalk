tests-code generation-expressions
testMapMergeEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1|-><one>, 2|-><two>} munion {3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapMerge'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{(1 -> #one).
			(2 -> #two).
			(3 -> #three)} asDictionary