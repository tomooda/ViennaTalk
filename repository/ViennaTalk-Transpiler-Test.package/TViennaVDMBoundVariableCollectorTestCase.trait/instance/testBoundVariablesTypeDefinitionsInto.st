tests-bound variables-definitions
testBoundVariablesTypeDefinitionsInto
	| node binds |
	node := ViennaVDMParser new typeDefinitions end parse: 'types public t1 = t2 inv v1 == e1; public t3 = t4 inv v2 == e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeDefinitions'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't3'} asSet