tests-code generation-expressions
testFloorEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'floor 1.5'.
	self deny: node isPetitFailure.
	self assert: node label = 'Floor'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 1