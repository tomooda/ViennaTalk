Trait {
	#name : #TViennaVDMBoundVariableCollectorTestCase,
	#category : #'ViennaTalk-Transpiler-Test'
}

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesAccessFunctionDefinitionInto [

	| node binds |
	node := ViennaVDMParser new accessFunctionDefinition end parse:
		        'public fn : t1 -> t2 fn(x) == x'.
	self deny: node isPetit2Failure.
	self assert: node isViennaAccessFunctionDefinitionNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'fn' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesAccessOperationDefinitionInto [

	| node binds |
	node := ViennaVDMParser new accessOperationDefinition end parse:
		        'public op : t1 ==> t2 op(x) == return x'.
	self deny: node isPetit2Failure.
	self assert: node isViennaAccessOperationDefinitionNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'op' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesAccessTypeDefinitionInto [

	| node binds |
	node := ViennaVDMParser new accessTypeDefinition end parse:
		        'public t1 = t2 inv v == e'.
	self deny: node isPetit2Failure.
	self assert: node isViennaAccessTypeDefinitionNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 't1' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesAccessValueDefinitionInto [

	| node binds |
	node := ViennaVDMParser new accessValueDefinition end parse:
		        'public v1 = e1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaAccessValueDefinitionNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesAssignmentDefinitionInto [

	| node binds |
	node := ViennaVDMParser new assignmentDefinition end parse:
		        'v:t := e'.
	self deny: node isPetit2Failure.
	self assert: node isViennaAssignmentDefinitionNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v' } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesBindListInto [

	| node binds |
	node := ViennaVDMParser new bindList end parse:
		        'v1 : t1, v2 in set s1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaBindListNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-statements' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesBlockStatementInto [

	| node binds |
	node := ViennaVDMParser new blockStatement end parse:
		        '(dcl v1:t1 := e, v2:t1 := v1; dcl v3:t3 := f(v1, v2); op(v1, v2, v3))'.
	self deny: node isPetit2Failure.
	self assert: node isViennaBlockStatementNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2'. 'v3' } asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesCompositeTypeInto [

	| node binds |
	node := ViennaVDMParser new compositeType end parse:
		        'compose T of f1 : t1 f2 :- t2 t3 end'.
	self deny: node isPetit2Failure.
	self assert: node isViennaCompositeTypeNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'T' } asSet
]

{ #category : #'tests-bound variables-statements' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesDclStatementInto [

	| node binds |
	node := ViennaVDMParser new dclStatement end parse:
		        'dcl v1:t1 := e, v2:t := v1;'.
	self deny: node isPetit2Failure.
	self assert: node isViennaDclStatementNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesDefinitionBlockInto [

	| node binds |
	node := ViennaVDMParser new definitionBlock end parse:
		        'values v1 = e1; v2 = e2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaDefinitionBlockNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesDocumentInto [

	| node binds |
	node := ViennaVDMParser new document end parse:
		        'types t1 = t2; t3 = t4; values v1:t5 = e1; v2:t6 = e2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaDocumentNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 't1'. 't3'. 'v1'. 'v2' } asSet.
	node := ViennaVDMParser new document end parse:
		        'module m1 exports all definitions values v1 : t1 = e1 end m1 module m2 exports all definitions values v2 : t2 = e2 end m2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaDocumentNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'm1'. 'm2' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesEqualDefinitionInto [

	| node binds |
	node := ViennaVDMParser new equalDefinition end parse: 'v1 : t1 = e1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaEqualDefinitionNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesEqualDefinitionListInto [

	| node binds |
	node := ViennaVDMParser new equalDefinitionList end parse:
		        'v1 : t1 = e1; v2 : t2 = e2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaEqualDefinitionListNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesExplicitFunctionDefinitionInto [

	| node binds |
	node := ViennaVDMParser new explicitFunctionDefinition end parse:
		        'fn[@t] : t1 -> t2 fn(x) == e'.
	self deny: node isPetit2Failure.
	self assert: node isViennaExplicitFunctionDefinitionNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'fn' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesExplicitOperationDefinitionInto [

	| node binds |
	node := ViennaVDMParser new explicitOperationDefinition end parse:
		        'op: t1 ==> t2 op(x) == return e'.
	self deny: node isPetit2Failure.
	self assert: node isViennaExplicitOperationDefinitionNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'op' } asSet
]

{ #category : #'tests-bound variables-interfaces' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesExportDefinitionInto [

	| node binds |
	node := ViennaVDMParser new exportDefinition end parse:
		        'exports types t1; t2; values v1:t3; v2:t4'.
	self deny: node isPetit2Failure.
	self assert: node isViennaExportDefinitionNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals: { 't1'. 't2'. 't3'. 't4'. 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-interfaces' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesExportFunctionsSignatureInto [

	| node binds |
	node := ViennaVDMParser new exportFunctionsSignature end parse:
		        'functions f1[@t1,@t2]:t3->t4; f2[@t5,@t6]:t7->t8'.
	self deny: node isPetit2Failure.
	self assert: node isViennaExportFunctionsSignatureNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals: { 'f1'. 't3'. 't4'. 'f2'. 't7'. 't8' } asSet
]

{ #category : #'tests-bound variables-interfaces' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesExportModuleSignatureInto [

	| node binds |
	node := ViennaVDMParser new exportModuleSignature end parse:
		        'values v1 : t1; types t2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaExportModuleSignatureNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 't1'. 't2' } asSet
]

{ #category : #'tests-bound variables-interfaces' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesExportTypesSignatureInto [

	| node binds |
	node := ViennaVDMParser new exportTypesSignature end parse:
		        'types t1; t2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaExportTypesSignatureNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 't1'. 't2' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesExtendedExplicitFunctionDefinitionInto [
	| node binds |
	node := ViennaVDMParser new extendedExplicitFunctionDefinition end
		parse: 'fn[@t](x:t1) res:t2 == e post b'.
	self deny: node isPetit2Failure.
	self assert: node label = 'ExtendedExplicitFunctionDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'fn' . 'post_fn'} asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesFieldInto [

	| node binds |
	node := ViennaVDMParser new field end parse: 'f : t'.
	self deny: node isPetit2Failure.
	self assert: node isViennaFieldNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'f' } asSet.
	node := ViennaVDMParser new field end parse: 'f :- t'.
	self deny: node isPetit2Failure.
	self assert: node isViennaFieldNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'f' } asSet.
	node := ViennaVDMParser new field end parse: 't'.
	self deny: node isPetit2Failure.
	self assert: node isViennaFieldNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {  } asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesFieldListInto [

	| node binds |
	node := ViennaVDMParser new fieldList end parse:
		        'f1 : t1 f2 :- t2 t3'.
	self deny: node isPetit2Failure.
	self assert: node isViennaFieldListNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'f1'. 'f2' } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesFieldPatternInto [
	| node binds |
	node := ViennaVDMParser new fieldPattern end parse: 'f1 |-> v'.
	self deny: node isPetit2Failure.
	self assert: node isViennaFieldPatternNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesFieldPatternListInto [

	| node binds |
	node := ViennaVDMParser new fieldPatternList end parse:
		        'f1 |-> v1, f2 |-> v2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaFieldPatternListNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesFunctionDefinitionInto [
	| node binds |
	node := ViennaVDMParser new functionDefinition end parse: 'fn[@t] : t1 -> t2 fn(x) == e'.
	self deny: node isPetit2Failure.
	self assert: node label = 'FunctionDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'fn'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesFunctionDefinitionsInto [
	| node binds |
	node := ViennaVDMParser new functionDefinitions end
		parse: 'functions fn1[@t] : t1 -> t2 fn1(x) == e1; fn2[@t] : t3 -> t4 fn2(y) == e2'.
	self deny: node isPetit2Failure.
	self assert: node label = 'FunctionDefinitions'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'fn1'.
			'fn2'} asSet
]

{ #category : #'tests-bound variables-interfaces' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesFunctionExportInto [

	| node binds |
	node := ViennaVDMParser new functionExport end parse:
		        'f1[@t1,@t2]:t3->t4'.
	self deny: node isPetit2Failure.
	self assert: node isViennaFunctionExportNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'f1'. 't3'. 't4' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesImplicitFunctionDefinitionInto [
	| node binds |
	node := ViennaVDMParser new implicitFunctionDefinition end parse: 'fn[@t](p1:t1,p2:t2)i:t post b'.
	self deny: node isPetit2Failure.
	self assert: node label = 'ImplicitFunctionDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'fn'. 'post_fn'} asSet
]

{ #category : #'tests-bound variables-statements' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesIndexForLoopInto [

	| node binds |
	node := ViennaVDMParser new indexForLoop end parse:
		        'for v = e1 to e2 by e3 do op(v)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaIndexForLoopNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v' } asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesInmapTypeInto [

	| node binds |
	node := ViennaVDMParser new inmapType end parse: 'inmap t1 to t2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaInmapTypeNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {  } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesLocalDefinitionInto [

	| node binds |
	node := ViennaVDMParser new localDefinition end parse: 'v1 : t1 = e1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLocalDefinitionNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesLocalDefinitionListInto [

	| node binds |
	node := ViennaVDMParser new localDefinitionList end parse:
		        'v1 : t1 = e1, fn[@t] : t2 -> t3 fn(x) == e2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLocalDefinitionListNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'fn' } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesMapEnumerationPatternInto [

	| node binds |
	node := ViennaVDMParser new mapEnumerationPattern end parse:
		        '{k1 |-> v1, k2 |-> v2}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapEnumerationPatternNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'k1'. 'v1'. 'k2'. 'v2' } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesMapMunionPatternInto [

	| node binds |
	node := ViennaVDMParser new mapMunionPattern end parse:
		        '{k1 |-> v1, k2 |-> v2} munion {k3 |-> v3}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapMunionPatternNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals: { 'k1'. 'v1'. 'k2'. 'v2'. 'k3'. 'v3' } asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesMapTypeInto [

	| node binds |
	node := ViennaVDMParser new mapType end parse: 'map t1 to t2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapTypeNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {  } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesMapletPatternInto [

	| node binds |
	node := ViennaVDMParser new mapletPattern end parse: 'k |-> v'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapletPatternNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'k'. 'v' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesModuleInto [

	| node binds |
	node := ViennaVDMParser new module end parse:
		        'module m1 exports all definitions values v1 : t1 = e1 end m1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaModuleNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'm1' } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesMultipleSetBindInto [

	| node binds |
	node := ViennaVDMParser new multipleSetBind end parse:
		        'v1, v2 in set s'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMultipleSetBindNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesMultipleTypeBindInto [

	| node binds |
	node := ViennaVDMParser new multipleTypeBind end parse: 'v1, v2 : t'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMultipleTypeBindNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesOperationDefinitionInto [
	| node binds |
	node := ViennaVDMParser new operationDefinition end parse: 'op: t1 ==> t2 op(x) == return e'.
	self deny: node isPetit2Failure.
	self assert: node label = 'OperationDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'op'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesOperationDefinitionsInto [
	| node binds |
	node := ViennaVDMParser new operationDefinitions end
		parse: 'operations op1: t1 ==> t2 op1(x) == return e1; op2: t3 ==> t4 op2(y) == return e2'.
	self deny: node isPetit2Failure.
	self assert: node label = 'OperationDefinitions'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'op1'.
			'op2'} asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesOperationTypeInto [

	| node binds |
	node := ViennaVDMParser new operationType end parse: 't1 ==> t2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaOperationTypeNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {  } asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesOptionalTypeInto [

	| node binds |
	node := ViennaVDMParser new optionalType end parse: '[t]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaOptionalTypeNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {  } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesParametersInto [

	| node binds |
	node := ViennaVDMParser new parameters end parse: '(x, y)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaParametersNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'x'. 'y' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesParametersListInto [

	| node binds |
	node := ViennaVDMParser new parametersList end parse: '(x, y)(z)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaParametersListNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'x'. 'y'. 'z' } asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesPartialFunctionTypeInto [

	| node binds |
	node := ViennaVDMParser new partialFunctionType end parse: 't1 -> t2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaPartialFunctionTypeNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {  } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesPatternIdentifierInto [

	| node binds |
	node := ViennaVDMParser new patternIdentifier end parse: 'v'.
	self deny: node isPetit2Failure.
	self assert: node isViennaPatternIdentifierNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v' } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesPatternListInto [

	| node binds |
	node := ViennaVDMParser new patternList end parse: 'v1, v2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaPatternListNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesProductTypeInto [

	| node binds |
	node := ViennaVDMParser new productType end parse: 't1 * t2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaProductTypeNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {  } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesRecordPatternInto [

	| node binds |
	node := ViennaVDMParser new recordPattern end parse: 'mk_T(v1, v2)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaRecordPatternNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesRecordTypeDefinitionInto [
	| node binds |
	node := ViennaVDMParser new recordTypeDefinition end parse: 'T::f1:t1 f2:-t2 t3'.
	self deny: node isPetit2Failure.
	self assert: node label = 'RecordTypeDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'T'} asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesSeq1TypeInto [

	| node binds |
	node := ViennaVDMParser new seq1Type end parse: 'seq1 of t'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSeq1TypeNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {  } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesSeqConcPatternInto [

	| node binds |
	node := ViennaVDMParser new seqConcPattern end parse:
		        '[v1, v2] ^ [v3]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSeqConcPatternNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2'. 'v3' } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesSeqEnumPatternInto [

	| node binds |
	node := ViennaVDMParser new seqEnumPattern end parse: '[v1, v2]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSeqEnumPatternNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesSeqTypeInto [

	| node binds |
	node := ViennaVDMParser new seqType end parse: 'seq of t'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSeqTypeNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {  } asSet
]

{ #category : #'tests-bound variables-statements' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesSequenceForLoopInto [

	| node binds |
	node := ViennaVDMParser new sequenceForLoop end parse:
		        'for v in s do op(v)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceForLoopNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v' } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesSetBindInto [

	| node binds |
	node := ViennaVDMParser new setBind end parse: 'v in set s'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetBindNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v' } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesSetEnumPatternInto [

	| node binds |
	node := ViennaVDMParser new setEnumPattern end parse: '{v1, v2}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetEnumPatternNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-statements' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesSetForLoopInto [

	| node binds |
	node := ViennaVDMParser new setForLoop end parse:
		        'for all v in set s do op(v)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetForLoopNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v' } asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesSetTypeInto [

	| node binds |
	node := ViennaVDMParser new setType end parse: 'set of t'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetTypeNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {  } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesSetUnionPatternInto [

	| node binds |
	node := ViennaVDMParser new setUnionPattern end parse:
		        '{v1, v2} union {v3}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetUnionPatternNode.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2'. 'v3' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesStateDefinitionInto [
	| node binds |
	node := ViennaVDMParser new stateDefinition end
		parse: 'state S of v1 : t1 v2 : t2 inv mk_S(inv1, inv2) == inv1 = inv2 init s == s = mk_S(e1, e2) end'.
	self deny: node isPetit2Failure.
	self assert: node label = 'StateDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'S'.
			'v1'.
			'v2'.
			'inv_S'.
			'init_S'.
			'state'} asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesTotalFunctionTypeInto [

	| node binds |
	node := ViennaVDMParser new totalFunctionType end parse: 't1 +> t2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaTotalFunctionTypeNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {  } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesTuplePatternInto [

	| node binds |
	node := ViennaVDMParser new tuplePattern end parse: 'mk_(v1, v2)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaTuplePatternNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesTypeBindInto [

	| node binds |
	node := ViennaVDMParser new typeBind end parse: 'v : t'.
	self deny: node isPetit2Failure.
	self assert: node isViennaTypeBindNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v' } asSet
]

{ #category : #'tests-bound variables-patterns and binds' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesTypeBindListInto [

	| node binds |
	node := ViennaVDMParser new typeBindList end parse:
		        'v1 : t1, v2 : t2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaTypeBindListNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { 'v1'. 'v2' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesTypeDefinitionInto [
	| node binds |
	node := ViennaVDMParser new typeDefinition end parse: 't1 = t2 inv v == e'.
	self deny: node isPetit2Failure.
	self assert: node label = 'TypeDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'t1'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesTypeDefinitionsInto [
	| node binds |
	node := ViennaVDMParser new typeDefinitions end parse: 'types public t1 = t2 inv v1 == e1; public t3 = t4 inv v2 == e2'.
	self deny: node isPetit2Failure.
	self assert: node label = 'TypeDefinitions'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't3'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesTypeVariableIdentifierInto [

	| node binds |
	node := ViennaVDMParser new typeVariableIdentifier end parse: '@t'.
	self deny: node isPetit2Failure.
	self assert: node isViennaTypeVariableIdentifierNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { '@t' } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesTypeVariableListInto [

	| node binds |
	node := ViennaVDMParser new typeVariableList end parse: '[@t1, @t2]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaTypeVariableListNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: { '@t1'. '@t2' } asSet
]

{ #category : #'tests-bound variables-types' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesUnionTypeInto [

	| node binds |
	node := ViennaVDMParser new unionType end parse: 't1 | t2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaUnionTypeNode.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {  } asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesValueDefinitionInto [
	| node binds |
	node := ViennaVDMParser new valueDefinition end parse: 'v : t = e'.
	self deny: node isPetit2Failure.
	self assert: node label = 'ValueDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet
]

{ #category : #'tests-bound variables-definitions' }
TViennaVDMBoundVariableCollectorTestCase >> testBoundVariablesValueDefinitionsInto [
	| node binds |
	node := ViennaVDMParser new valueDefinitions end parse: 'values public v1 : t1 = e1 ; public v2 : t2 = e2'.
	self deny: node isPetit2Failure.
	self assert: node label = 'ValueDefinitions'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet
]
