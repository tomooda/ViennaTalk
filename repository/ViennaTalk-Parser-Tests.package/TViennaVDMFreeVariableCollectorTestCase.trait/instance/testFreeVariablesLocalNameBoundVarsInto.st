tests-free variables-expressions
testFreeVariablesLocalNameBoundVarsInto
	| node binds |
	node := ViennaVDMParser new name end parse: 'v'.
	self deny: node isPetitFailure.
	self assert: node label = 'LocalName'.
	binds := Set new.
	self assert: (ViennaVDM2Smalltalk new freeVariables: node env: Dictionary new) equals: {'v'} asSet