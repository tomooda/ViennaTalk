tests-code generation-expressions
testSubsequenceEnv
	| node |
	node := ViennaVDMParser new expression end parse: '[4,5,6,7,8](2,...,4)'.
	self deny: node isPetitFailure.
	self assert: node label = 'Subsequence'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{5.
			6.
			7} asOrderedCollection