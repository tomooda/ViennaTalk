tests-code generation-expressions
testMapDomainRestrictedToEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{2, 3} <: {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapDomainRestrictedTo'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{(2 -> #two).
			(3 -> #three)} asDictionary