tests-bound variables-types
testBoundVariablesCompositeTypeInto
	| node binds |
	node := ViennaVDMParser new compositeType end parse: 'compose T of f1 : t1 f2 :- t2 t3 end'.
	self deny: node isPetitFailure.
	self assert: node label = 'CompositeType'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'T'.
			't1'.
			't2'.
			't3'} asSet