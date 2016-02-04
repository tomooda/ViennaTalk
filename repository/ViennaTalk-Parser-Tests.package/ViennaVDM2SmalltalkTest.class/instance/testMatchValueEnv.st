tests-code generation-expressions
testMatchValueEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'def  ({10|->20}) munion { x|->y } = { 1 |-> 2, 10 |-> 20} in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first first label = 'MatchValue'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3