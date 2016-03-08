tests-code generation-expressions
testMapMunionPatternEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'def  { x|->y } munion { 10|->20 } = { 1 |-> 2, 10 |-> 20} in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'MapMunionPattern'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 3