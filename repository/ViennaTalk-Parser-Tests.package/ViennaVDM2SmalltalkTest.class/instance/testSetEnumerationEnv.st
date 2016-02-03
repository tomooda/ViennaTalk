tests-code generation-expressions
testSetEnumerationEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{4,5,6}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetEnumeration'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{4.
			5.
			6} asSet