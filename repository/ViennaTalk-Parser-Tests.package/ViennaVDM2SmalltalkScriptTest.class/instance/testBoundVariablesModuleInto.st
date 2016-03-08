tests-bound variables-definitions
testBoundVariablesModuleInto
	| node binds |
	node := ViennaVDMParser new module end parse: 'module m1 exports all definitions values v1 : t1 = e1 end m1'.
	self deny: node isPetitFailure.
	self assert: node label = 'Module'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'m1'} asSet