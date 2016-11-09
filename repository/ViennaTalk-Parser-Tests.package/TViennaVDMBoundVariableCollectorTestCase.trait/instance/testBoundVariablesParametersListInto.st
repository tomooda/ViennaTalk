tests-bound variables-definitions
testBoundVariablesParametersListInto
	| node binds |
	node := ViennaVDMParser new parametersList end parse: '(x, y)(z)'.
	self deny: node isPetitFailure.
	self assert: node label = 'ParametersList'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'x'.
			'y'.
			'z'} asSet