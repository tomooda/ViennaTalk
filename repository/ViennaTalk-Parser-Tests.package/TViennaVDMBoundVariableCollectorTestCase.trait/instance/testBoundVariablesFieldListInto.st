tests-bound variables-types
testBoundVariablesFieldListInto
	| node binds |
	node := ViennaVDMParser new fieldList end parse: 'f1 : t1 f2 :- t2 t3'.
	self deny: node isPetitFailure.
	self assert: node label = 'FieldList'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'f1'.
			'f2'} asSet