tests-code generation-expressions
testMapEnumerationPatternEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'def  { x |-> 1, 2 |-> y } = { 1 |-> 1, 2 |-> 2 } in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'MapEnumerationPattern'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 3