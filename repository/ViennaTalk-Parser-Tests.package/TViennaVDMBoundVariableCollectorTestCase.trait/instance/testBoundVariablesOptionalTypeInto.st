tests-bound variables-types
testBoundVariablesOptionalTypeInto
	| node binds |
	node := ViennaVDMParser new optionalType end parse: '[t]'.
	self deny: node isPetitFailure.
	self assert: node label = 'OptionalType'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {} asSet