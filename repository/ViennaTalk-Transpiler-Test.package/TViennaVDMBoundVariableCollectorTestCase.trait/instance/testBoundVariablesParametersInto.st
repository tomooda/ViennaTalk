tests-bound variables-definitions
testBoundVariablesParametersInto
	| node binds |
	node := ViennaVDMParser new parameters end parse: '(x, y)'.
	self deny: node isPetitFailure.
	self assert: node label = 'Parameters'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'x'.
			'y'} asSet