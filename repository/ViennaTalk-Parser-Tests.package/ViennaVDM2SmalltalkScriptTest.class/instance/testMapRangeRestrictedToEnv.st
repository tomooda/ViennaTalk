tests-code generation-expressions
testMapRangeRestrictedToEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1|-><one>, 2|-><two>, 3|-><three>} :> {<one>, <two>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapRangeRestrictedTo'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{(1 -> #one).
			(2 -> #two)} asDictionary