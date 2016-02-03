tests-code generation-expressions
testMapRangeRestrictedByEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1|-><one>, 2|-><two>, 3|-><three>} :-> {<three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapRangeRestrictedBy'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> #one).
			(2 -> #two)} asDictionary