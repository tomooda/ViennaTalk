tests-code generation-expressions
testProperSubsetEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1,2} psubset {1,2,3}'.
	self deny: node isPetitFailure.
	self assert: node label = 'ProperSubset'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '{1,2} psubset {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'ProperSubset'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: '{1,2,3} psubset {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'ProperSubset'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: false