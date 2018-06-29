Trait {
	#name : #TViennaVDMBoundVariableCollector,
	#category : 'ViennaTalk-Parser-Core'
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
	aSet add: aViennaNode first
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
	constructor := aViennaNode first.
	fieldList := aViennaNode second.
	aSet add: constructor.
	fieldList
		do: [ :field | 
			| type |
			type := field third.
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
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesEqualDefinitionList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesExplicitFunctionDefinition: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesExplicitOperationDefinition: aViennaNode into: aSet [
	aSet add: aViennaNode first
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
TViennaVDMBoundVariableCollector >> boundVariablesExportTypesSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesField: aViennaNode into: aSet [
	aViennaNode first ifNotNil: [ :name | aSet add: name ]
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
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesFunctionDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesFunctionExport: aViennaNode into: aSet [
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self freeVariables: aViennaNode third boundVars: aSet into: aSet
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesFunctionImport: aViennaNode into: aSet [
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self boundVariables: aViennaNode third into: aSet.
	aViennaNode fourth ifNotNil: [ :rename | aSet add: rename first ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesFunctionSignature: aViennaNode into: aSet [
	aViennaNode first do: [ :localName | aSet add: localName first ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesFunctionsSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
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
	aSet add: aViennaNode first
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesInmapType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesLocalDefinition: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
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
	aSet add: aViennaNode first
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesModuleBody: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesMultipleSetBind: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesMultipleTypeBind: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesObjectPattern: aViennaNode into: aSet [
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesOperationDefinition: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesOperationDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesOperationImport: aViennaNode into: aSet [
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self boundVariables: aViennaNode second into: aSet.
	aViennaNode third ifNotNil: [ :rename | aSet add: rename first ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesOperationSignature: aViennaNode into: aSet [
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesOperationType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesOperationsSignature: aViennaNode into: aSet [
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
	aViennaNode first ifNotNil: [ :string | aSet add: string ]
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
	constructor := aViennaNode first.
	fieldList := aViennaNode second.
	aSet add: constructor.
	fieldList
		do: [ :field | 
			| type |
			type := field third.
			self boundVariables: type into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMBoundVariableCollector >> boundVariablesSeq1Type: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
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
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesSetBind: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesSetEnumPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-statements' }
TViennaVDMBoundVariableCollector >> boundVariablesSetForLoop: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
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
	identifier := aViennaNode first.
	stateFieldList := aViennaNode second.
	invariant := aViennaNode third.
	initialisation := aViennaNode fourth.
	aSet add: identifier.
	invariant ifNotNil: [ aSet add: 'inv_' , identifier ].
	initialisation ifNotNil: [ aSet add: 'init_' , identifier ].
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
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeBindList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeDefinition: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeImport: aViennaNode into: aSet [
	aSet add: aViennaNode first.
	aViennaNode second ifNotNil: [ :rename | aSet add: rename first ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeNameExport: aViennaNode into: aSet [
	aSet add: aViennaNode first first
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeStructExport: aViennaNode into: aSet [
	aSet add: aViennaNode first first
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeVariableIdentifier: aViennaNode into: aSet [
	aSet add: aViennaNode first
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
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesValueDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesValueImport: aViennaNode into: aSet [
	aSet add: aViennaNode first.
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesValueSignature: aViennaNode into: aSet [
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self freeVariables: aViennaNode second boundVars: aSet into: aSet
]

{ #category : #'bound variables-interfaces' }
TViennaVDMBoundVariableCollector >> boundVariablesValuesSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]
