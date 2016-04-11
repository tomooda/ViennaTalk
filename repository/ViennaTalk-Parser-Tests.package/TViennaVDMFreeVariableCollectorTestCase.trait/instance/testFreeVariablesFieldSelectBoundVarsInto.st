tests-free variables-expressions
testFreeVariablesFieldSelectBoundVarsInto
	| node binds |
	node := ViennaVDMParser new expression end parse: 'record.field'.
	self deny: node isPetitFailure.
	self assert: node label = 'FieldSelect'.
	binds := Set new.
	self assert: (ViennaVDM2Smalltalk new freeVariables: node env: Dictionary new) equals: {'record'} asSet