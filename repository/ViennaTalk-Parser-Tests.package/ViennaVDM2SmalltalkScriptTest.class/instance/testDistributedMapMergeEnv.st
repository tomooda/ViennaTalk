tests-code generation-expressions
testDistributedMapMergeEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'merge {{1|->2}, {2|->3}}'.
	self deny: node isPetitFailure.
	self assert: node label = 'DistributedMapMerge'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{(1 -> 2).
			(2 -> 3)} asDictionary