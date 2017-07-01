tests-code generation-expressions
testFinitePowerSetEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'power {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'FinitePowerSet'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			(Set
				with: Set new
				with: (Set with: 1)
				with: (Set with: 2)
				with: (Set with: 1 with: 2))