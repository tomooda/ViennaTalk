Trait {
	#name : #TViennaVDMBoundVariableCollectorTest,
	#category : 'ViennaTalk-Parser-Tests'
}

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesAccessFunctionDefinitionInto [
	| node binds |
	node := ViennaVDMParser new accessFunctionDefinition end parse: 'public fn : t1 -> t2 fn(x) == x'.
	self deny: node isPetitFailure.
	self assert: node label = 'AccessFunctionDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'fn'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesAccessOperationDefinitionInto [
	| node binds |
	node := ViennaVDMParser new accessOperationDefinition end parse: 'public op : t1 ==> t2 op(x) == return x'.
	self deny: node isPetitFailure.
	self assert: node label = 'AccessOperationDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'op'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesAccessTypeDefinitionInto [
	| node binds |
	node := ViennaVDMParser new accessTypeDefinition end parse: 'public t1 = t2 inv v == e'.
	self deny: node isPetitFailure.
	self assert: node label = 'AccessTypeDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'t1'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesAccessValueDefinitionInto [
	| node binds |
	node := ViennaVDMParser new accessValueDefinition end parse: 'public v1 = e1'.
	self deny: node isPetitFailure.
	self assert: node label = 'AccessValueDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v1'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesAssignmentDefinitionInto [
	| node binds |
	node := ViennaVDMParser new assignmentDefinition end parse: 'v:t := e'.
	self deny: node isPetitFailure.
	self assert: node label = 'AssignmentDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesBindListInto [
	| node binds |
	node := ViennaVDMParser new bindList end parse: 'v1 : t1, v2 in set s1'.
	self deny: node isPetitFailure.
	self assert: node label = 'BindList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesDefinitionBlockInto [
	| node binds |
	node := ViennaVDMParser new definitionBlock end parse: 'values v1 = e1; v2 = e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'DefinitionBlock'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesDocumentInto [
	| node binds |
	node := ViennaVDMParser new document end parse: 'types t1 = t2; t3 = t4; values v1:t5 = e1; v2:t6 = e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'Document'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't3'.
			'v1'.
			'v2'} asSet.
	node := ViennaVDMParser new document end
		parse:
			'module m1 exports all definitions values v1 : t1 = e1 end m1 module m2 exports all definitions values v2 : t2 = e2 end m2'.
	self deny: node isPetitFailure.
	self assert: node label = 'Document'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'m1'.
			'm2'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesEqualDefinitionInto [
	| node binds |
	node := ViennaVDMParser new equalDefinition end parse: 'v1 : t1 = e1'.
	self deny: node isPetitFailure.
	self assert: node label = 'EqualDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v1'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesEqualDefinitionListInto [
	| node binds |
	node := ViennaVDMParser new equalDefinitionList end parse: 'v1 : t1 = e1; v2 : t2 = e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'EqualDefinitionList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesExplicitFunctionDefinitionInto [
	| node binds |
	node := ViennaVDMParser new explicitFunctionDefinition end parse: 'fn[@t] : t1 -> t2 fn(x) == e'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExplicitFunctionDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'fn'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesExplicitOperationDefinitionInto [
	| node binds |
	node := ViennaVDMParser new explicitOperationDefinition end parse: 'op: t1 ==> t2 op(x) == return e'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExplicitOperationDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'op'} asSet
]

{ #category : #'test-bound variables-types' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesFieldInto [
	| node binds |
	node := ViennaVDMParser new field end parse: 'f : t'.
	self deny: node isPetitFailure.
	self assert: node label = 'Field'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'f'} asSet.
	node := ViennaVDMParser new field end parse: 'f :- t'.
	self deny: node isPetitFailure.
	self assert: node label = 'Field'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'f'} asSet.
	node := ViennaVDMParser new field end parse: 't'.
	self deny: node isPetitFailure.
	self assert: node label = 'Field'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {} asSet
]

{ #category : #'test-bound variables-types' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesFieldListInto [
	| node binds |
	node := ViennaVDMParser new fieldList end parse: 'f1 : t1 f2 :- t2 t3'.
	self deny: node isPetitFailure.
	self assert: node label = 'FieldList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'f1'.
			'f2'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesFieldPatternInto [
	| node binds |
	node := ViennaVDMParser new fieldPattern end parse: 'f1 |-> v'.
	self deny: node isPetitFailure.
	self assert: node label = 'FieldPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesFieldPatternListInto [
	| node binds |
	node := ViennaVDMParser new fieldPatternList end parse: 'f1 |-> v1, f2 |-> v2'.
	self deny: node isPetitFailure.
	self assert: node label = 'FieldPatternList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesFunctionDefinitionInto [
	| node binds |
	node := ViennaVDMParser new functionDefinition end parse: 'fn[@t] : t1 -> t2 fn(x) == e'.
	self deny: node isPetitFailure.
	self assert: node label = 'FunctionDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'fn'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesFunctionDefinitionsInto [
	| node binds |
	node := ViennaVDMParser new functionDefinitions end
		parse: 'functions fn1[@t] : t1 -> t2 fn1(x) == e1; fn2[@t] : t3 -> t4 fn2(y) == e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'FunctionDefinitions'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'fn1'.
			'fn2'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesLocalDefinitionInto [
	| node binds |
	node := ViennaVDMParser new localDefinition end parse: 'v1 : t1 = e1'.
	self deny: node isPetitFailure.
	self assert: node label = 'LocalDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v1'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesLocalDefinitionListInto [
	| node binds |
	node := ViennaVDMParser new localDefinitionList end parse: 'v1 : t1 = e1, fn[@t] : t2 -> t3 fn(x) == e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'LocalDefinitionList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'fn'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesMapEnumerationPatternInto [
	| node binds |
	node := ViennaVDMParser new mapEnumerationPattern end parse: '{k1 |-> v1, k2 |-> v2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapEnumerationPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'k1'.
			'v1'.
			'k2'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesMapMunionPatternInto [
	| node binds |
	node := ViennaVDMParser new mapMunionPattern end parse: '{k1 |-> v1, k2 |-> v2} munion {k3 |-> v3}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapMunionPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'k1'.
			'v1'.
			'k2'.
			'v2'.
			'k3'.
			'v3'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesMapletPatternInto [
	| node binds |
	node := ViennaVDMParser new mapletPattern end parse: 'k |-> v'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapletPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'k'.
			'v'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesModuleInto [
	| node binds |
	node := ViennaVDMParser new module end parse: 'module m1 exports all definitions values v1 : t1 = e1 end m1'.
	self deny: node isPetitFailure.
	self assert: node label = 'Module'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'m1'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesMultipleSetBindInto [
	| node binds |
	node := ViennaVDMParser new multipleSetBind end parse: 'v1, v2 in set s'.
	self deny: node isPetitFailure.
	self assert: node label = 'MultipleSetBind'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesMultipleTypeBindInto [
	| node binds |
	node := ViennaVDMParser new multipleTypeBind end parse: 'v1, v2 : t'.
	self deny: node isPetitFailure.
	self assert: node label = 'MultipleTypeBind'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesObjectPatternInto [
	| node binds |
	node := ViennaVDMParser new objectPattern end parse: 'obj_T(f1 |-> v1, f2 |-> v2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'ObjectPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesOperationDefinitionInto [
	| node binds |
	node := ViennaVDMParser new operationDefinition end parse: 'op: t1 ==> t2 op(x) == return e'.
	self deny: node isPetitFailure.
	self assert: node label = 'OperationDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'op'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesOperationDefinitionsInto [
	| node binds |
	node := ViennaVDMParser new operationDefinitions end
		parse: 'operations op1: t1 ==> t2 op1(x) == return e1; op2: t3 ==> t4 op2(y) == return e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'OperationDefinitions'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'op1'.
			'op2'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesParametersInto [
	| node binds |
	node := ViennaVDMParser new parameters end parse: '(x, y)'.
	self deny: node isPetitFailure.
	self assert: node label = 'Parameters'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'x'.
			'y'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesParametersListInto [
	| node binds |
	node := ViennaVDMParser new parametersList end parse: '(x, y)(z)'.
	self deny: node isPetitFailure.
	self assert: node label = 'ParametersList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'x'.
			'y'.
			'z'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesPatternIdentifierInto [
	| node binds |
	node := ViennaVDMParser new patternIdentifier end parse: 'v'.
	self deny: node isPetitFailure.
	self assert: node label = 'PatternIdentifier'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesPatternListInto [
	| node binds |
	node := ViennaVDMParser new patternList end parse: 'v1, v2'.
	self deny: node isPetitFailure.
	self assert: node label = 'PatternList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesRecordPatternInto [
	| node binds |
	node := ViennaVDMParser new recordPattern end parse: 'mk_T(v1, v2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'RecordPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesSeqConcPatternInto [
	| node binds |
	node := ViennaVDMParser new seqConcPattern  end parse: '[v1, v2] ^ [v3]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SeqConcPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'.
			'v3'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesSeqEnumPatternInto [
	| node binds |
	node := ViennaVDMParser new seqEnumPattern end parse: '[v1, v2]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SeqEnumPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesSetBindInto [
	| node binds |
	node := ViennaVDMParser new setBind end parse: 'v in set s'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetBind'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesSetEnumPatternInto [
	| node binds |
	node := ViennaVDMParser new setEnumPattern end parse: '{v1, v2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetEnumPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesSetUnionPatternInto [
	| node binds |
	node := ViennaVDMParser new setUnionPattern end parse: '{v1, v2} union {v3}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetUnionPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'.
			'v3'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesStateDefinitionInto [
	| node binds |
	node := ViennaVDMParser new stateDefinition end
		parse: 'state S of v1 : t1 v2 : t2 inv mk_S(inv1, inv2) == inv1 = inv2 init s == s = mk_S(e1, e2) end'.
	self deny: node isPetitFailure.
	self assert: node label = 'StateDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'S'.
			'v1'.
			'v2'.
			'inv_S'.
			'init_S'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesTuplePatternInto [
	| node binds |
	node := ViennaVDMParser new tuplePattern end parse: 'mk_(v1, v2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'TuplePattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesTypeBindInto [
	| node binds |
	node := ViennaVDMParser new typeBind end parse: 'v : t'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeBind'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesTypeBindListInto [
	| node binds |
	node := ViennaVDMParser new typeBindList end parse: 'v1 : t1, v2 : t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeBindList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesTypeDefinitionInto [
	| node binds |
	node := ViennaVDMParser new typeDefinition end parse: 't1 = t2 inv v == e'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'t1'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesTypeDefinitionsInto [
	| node binds |
	node := ViennaVDMParser new typeDefinitions end parse: 'types public t1 = t2 inv v1 == e1; public t3 = t4 inv v2 == e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeDefinitions'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't3'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesTypeVariableIdentifierInto [
	| node binds |
	node := ViennaVDMParser new typeVariableIdentifier end parse: '@t'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeVariableIdentifier'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'@t'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesTypeVariableListInto [
	| node binds |
	node := ViennaVDMParser new typeVariableList end parse: '[@t1, @t2]'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeVariableList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'@t1'.
			'@t2'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesValueDefinitionInto [
	| node binds |
	node := ViennaVDMParser new valueDefinition end parse: 'v : t = e'.
	self deny: node isPetitFailure.
	self assert: node label = 'ValueDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTest >> testBoundVariablesValueDefinitionsInto [
	| node binds |
	node := ViennaVDMParser new valueDefinitions end parse: 'values public v1 : t1 = e1 ; public v2 : t2 = e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ValueDefinitions'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]
