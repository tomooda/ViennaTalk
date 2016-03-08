tests-code generation-expressions
testIterateEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1|->2, 2|->3, 3|->4, 4|->5, 5|->1} ** 3'.
	self deny: node isPetitFailure.
	self assert: node label = 'Iterate'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{(1 -> 4).
			(2 -> 5).
			(3 -> 1).
			(4 -> 2).
			(5 -> 3)} asDictionary