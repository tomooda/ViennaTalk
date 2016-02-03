tests-code generation-expressions
testMapEnumerationEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapEnumeration'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> #one).
			(2 -> #two).
			(3 -> #three)} asDictionary