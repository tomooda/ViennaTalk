tests-bound variables-definitions
testBoundVariablesValueDefinitionsInto
	| node binds |
	node := ViennaVDMParser new valueDefinitions end parse: 'values public v1 : t1 = e1 ; public v2 : t2 = e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ValueDefinitions'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet