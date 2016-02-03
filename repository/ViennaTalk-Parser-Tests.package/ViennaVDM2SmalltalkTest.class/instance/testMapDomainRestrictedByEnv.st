tests-code generation-expressions
testMapDomainRestrictedByEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{3} <-: {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapDomainRestrictedBy'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> #one).
			(2 -> #two)} asDictionary