tests-bound variables-types
testBoundVariablesRecordTypeDefinitionInto
	| node binds |
	node := ViennaVDMParser new recordTypeDefinition end parse: 'T::f1:t1 f2:-t2 t3'.
	self deny: node isPetitFailure.
	self assert: node label = 'RecordTypeDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'T'} asSet