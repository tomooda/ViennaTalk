tests-code generation-expressions
testMapOrSequenceModifyEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1|-><one>, 2|-><two>, 3|->3} ++ {3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapOrSequenceModify'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> #one).
			(2 -> #two).
			(3 -> #three)} asDictionary.
	node := ViennaVDMParser new expression end parse: '[<one>, <two>, <many>] ++ {3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapOrSequenceModify'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{#one.
			#two.
			#three} asOrderedCollection