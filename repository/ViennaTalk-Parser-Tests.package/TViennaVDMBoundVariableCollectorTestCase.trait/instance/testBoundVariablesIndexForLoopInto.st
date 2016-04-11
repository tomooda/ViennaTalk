tests-bound variables-statements
testBoundVariablesIndexForLoopInto
	| node binds |
	node := ViennaVDMParser new indexForLoop end parse: 'for v = e1 to e2 by e3 do op(v)'.
	self deny: node isPetitFailure.
	self assert: node label = 'IndexForLoop'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet