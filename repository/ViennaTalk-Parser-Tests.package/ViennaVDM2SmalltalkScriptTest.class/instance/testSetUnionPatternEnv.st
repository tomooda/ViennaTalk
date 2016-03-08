tests-code generation-patterns
testSetUnionPatternEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'def  { x } union { y } = { 1, 2 } in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'SetUnionPattern'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 3