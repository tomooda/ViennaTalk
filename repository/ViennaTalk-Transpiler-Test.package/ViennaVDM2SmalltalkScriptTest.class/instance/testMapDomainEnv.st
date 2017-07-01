tests-code generation-expressions
testMapDomainEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'dom {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapDomain'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3} asSet