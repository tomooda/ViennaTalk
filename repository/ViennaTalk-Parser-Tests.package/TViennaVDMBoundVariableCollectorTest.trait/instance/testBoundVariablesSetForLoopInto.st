tests-bound variables-statements
testBoundVariablesSetForLoopInto
	| node binds |
	node := ViennaVDMParser new setForLoop end parse: 'for all v in set s do op(v)'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetForLoop'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet