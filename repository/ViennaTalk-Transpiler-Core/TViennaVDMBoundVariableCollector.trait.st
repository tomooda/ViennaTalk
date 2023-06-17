Trait {
	#name : #TViennaVDMBoundVariableCollector,
	#category : #'ViennaTalk-Transpiler-Core'
}

{ #category : #'bound variables' }
TViennaVDMBoundVariableCollector >> boundVariables: aViennaNode [
	| boundVars |
	boundVars := Set new.
	self boundVariables: aViennaNode into: boundVars.
	^ boundVars
]

{ #category : #'bound variables' }
TViennaVDMBoundVariableCollector >> boundVariables: aViennaNode into: aSet [
	(aViennaNode isString or: [ aViennaNode isNil ])
		ifFalse: [ 
			| selector |
			selector := ('boundVariables' , aViennaNode label , ':into:') asSymbol.
			(self respondsTo: selector)
				ifTrue: [ self perform: selector with: aViennaNode with: aSet ] ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesAccessFunctionDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesAccessOperationDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesAccessTypeDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesAccessValueDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesAssignmentDefinition: aViennaNode into: aSet [

	aSet add: aViennaNode identifier
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesBindList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-statements' }
TViennaVDMBoundVariableCollector >> boundVariablesBlockStatement: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesCompositeType: aViennaNode into: aSet [

	| constructor fieldList |
	constructor := aViennaNode identifier.
	fieldList := aViennaNode fieldList.
	aSet add: constructor.
	fieldList do: [ :field |
		| type |
		type := field type.
		self boundVariables: type into: aSet ]
]

{ #category : #'bound variables-statements' }
TViennaVDMBoundVariableCollector >> boundVariablesDclStatement: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesDefinitionBlock: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesDocument: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesEqualDefinition: aViennaNode into: aSet [

	self boundVariables: aViennaNode patternOrBind into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesEqualDefinitionList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesExplicitFunctionDefinition: aViennaNode into: aSet [

	aSet add: aViennaNode identifier.
	aViennaNode pre ifNotNil: [
		aSet add: 'pre_' , aViennaNode identifier ].
	aViennaNode post ifNotNil: [
		aSet add: 'post_' , aViennaNode identifier ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesExplicitOperationDefinition: aViennaNode into: aSet [

	aSet add: aViennaNode identifier.
	aViennaNode pre ifNotNil: [
		aSet add: 'pre_' , aViennaNode identifier ].
	aViennaNode post ifNotNil: [
		aSet add: 'post_' , aViennaNode identifier ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesExportDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesExportFunctionsSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesExportModuleSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesExportModuleSignatureAll: aViennaNode into: aSet [
	self notYetImplemented
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesExportOperationsSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesExportTypesSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesExportValuesSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesExtendedExplicitFunctionDefinition: aViennaNode into: aSet [

	aSet add: aViennaNode identifier.
	aViennaNode pre ifNotNil: [
		aSet add: 'pre_' , aViennaNode identifier ].
	aSet add: 'post_' , aViennaNode identifier
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesExtendedExplicitOperationDefinition: aViennaNode into: aSet [

	aSet add: aViennaNode identifier.
	aViennaNode pre ifNotNil: [
		aSet add: 'pre_' , aViennaNode identifier ].
	aSet add: 'post_' , aViennaNode identifier
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesField: aViennaNode into: aSet [

	aViennaNode identifier ifNotNil: [ :name | aSet add: name ]
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesFieldList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesFieldPattern: aViennaNode into: aSet [
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesFieldPatternList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesFunctionDefinition: aViennaNode into: aSet [

	self boundVariables: aViennaNode definition into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesFunctionDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesFunctionExport: aViennaNode into: aSet [

	aViennaNode nameList do: [ :localName |
		aSet add: localName identifier ].
	self freeVariables: aViennaNode type boundVars: aSet into: aSet
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesFunctionImport: aViennaNode into: aSet [

	aViennaNode nameList do: [ :localName |
		aSet add: localName identifier ].
	self boundVariables: aViennaNode type into: aSet.
	aViennaNode rename ifNotNil: [ :rename | aSet add: rename identifier ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesFunctionSignature: aViennaNode into: aSet [

	aViennaNode nameList do: [ :localName |
		aSet add: localName identifier ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesImplicitFunctionDefinition: aViennaNode into: aSet [

	aSet add: aViennaNode identifier.
	aViennaNode pre ifNotNil: [
		aSet add: 'pre_' , aViennaNode identifier ].
	aSet add: 'post_' , aViennaNode identifier
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesImplicitOperationDefinition: aViennaNode into: aSet [

	aSet add: aViennaNode identifier.
	aViennaNode implicitOperationBody pre ifNotNil: [
		aSet add: 'pre_' , aViennaNode identifier ].
	aSet add: 'post_' , aViennaNode identifier
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesImportDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesImportDefinitionList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesImportFunctionsSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesImportModuleSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesImportModuleSignatureAll: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesImportOperationsSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesImportTypesSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-statements' }
TViennaVDMBoundVariableCollector >> boundVariablesIndexForLoop: aViennaNode into: aSet [

	aSet add: aViennaNode identifier
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesInmapType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesLocalDefinition: aViennaNode into: aSet [

	self
		boundVariables: aViennaNode valueDefinitionOrFunctionDefinition
		into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesLocalDefinitionList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesMapEnumerationPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesMapMunionPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesMapType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesMapletPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesModule: aViennaNode into: aSet [

	aSet add: aViennaNode identifier
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesModuleBody: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesMultipleSeqBind: aViennaNode into: aSet [

	self boundVariables: aViennaNode patternList into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesMultipleSetBind: aViennaNode into: aSet [

	self boundVariables: aViennaNode patternList into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesMultipleTypeBind: aViennaNode into: aSet [

	self boundVariables: aViennaNode patternList into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesObjectPattern: aViennaNode into: aSet [
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesOperationDefinition: aViennaNode into: aSet [

	self boundVariables: aViennaNode definition into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesOperationDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesOperationExport: aViennaNode into: aSet [

	aViennaNode nameList do: [ :localName |
		aSet add: localName identifier ].
	self boundVariables: aViennaNode type into: aSet
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesOperationImport: aViennaNode into: aSet [

	aViennaNode nameList do: [ :localName |
		aSet add: localName identifier ].
	self boundVariables: aViennaNode type into: aSet.
	aViennaNode rename ifNotNil: [ :rename | aSet add: rename rename ]
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesOperationType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesOptionalType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesParameters: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesParametersList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesPartialFunctionType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesPatternIdentifier: aViennaNode into: aSet [

	aViennaNode identifier ifNotNil: [ :string | aSet add: string ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesPatternList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesProductType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesRecordPattern: aViennaNode into: aSet [
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesRecordTypeDefinition: aViennaNode into: aSet [

	| constructor fieldList |
	constructor := aViennaNode identifier.
	fieldList := aViennaNode fieldList.
	aSet add: constructor.
	fieldList do: [ :field |
		| type |
		type := field type.
		self boundVariables: type into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesSeq1Type: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesSeqBind: aViennaNode into: aSet [

	self boundVariables: aViennaNode pattern into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesSeqConcPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesSeqEnumPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesSeqType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-statements' }
TViennaVDMBoundVariableCollector >> boundVariablesSequenceForLoop: aViennaNode into: aSet [

	self boundVariables: aViennaNode patternOrBind into: aSet
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesSet1Type: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesSetBind: aViennaNode into: aSet [
	self boundVariables: aViennaNode pattern into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesSetEnumPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-statements' }
TViennaVDMBoundVariableCollector >> boundVariablesSetForLoop: aViennaNode into: aSet [

	self boundVariables: aViennaNode pattern into: aSet
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesSetType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesSetUnionPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesStateDefinition: aViennaNode into: aSet [

	| identifier stateFieldList invariant initialisation |
	identifier := aViennaNode identifier.
	stateFieldList := aViennaNode fieldList.
	invariant := aViennaNode inv.
	initialisation := aViennaNode init.
	aSet add: identifier.
	invariant ifNotNil: [ aSet add: 'inv_' , identifier ].
	initialisation ifNotNil: [ aSet add: 'init_' , identifier ].
	aSet add: 'state'.
	self boundVariables: stateFieldList into: aSet
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesTotalFunctionType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesTuplePattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeBind: aViennaNode into: aSet [

	self boundVariables: aViennaNode pattern into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeBindList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeImport: aViennaNode into: aSet [

	aSet add: aViennaNode identifier.
	aViennaNode rename ifNotNil: [ :rename | aSet add: rename identifier ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeNameExport: aViennaNode into: aSet [

	aSet add: aViennaNode identifier
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeStructExport: aViennaNode into: aSet [

	aSet add: aViennaNode identifier
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeSynonym: aViennaNode into: aSet [

	aSet add: aViennaNode identifier
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeVariableIdentifier: aViennaNode into: aSet [

	aSet add: aViennaNode identifier
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeVariableList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesUnionType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesValueDefinition: aViennaNode into: aSet [

	self boundVariables: aViennaNode pattern into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesValueDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesValueExport: aViennaNode into: aSet [

	aViennaNode nameList do: [ :localName |
		aSet add: localName identifier ].
	self freeVariables: aViennaNode type boundVars: aSet into: aSet
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesValueImport: aViennaNode into: aSet [

	aSet add: aViennaNode identifier.
	self boundVariables: aViennaNode type into: aSet
]
