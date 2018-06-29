Trait {
	#name : #TViennaVDMFreeVariableCollector,
	#traits : 'TViennaVDMBoundVariableCollector',
	#classTraits : 'TViennaVDMBoundVariableCollector classTrait',
	#category : 'ViennaTalk-Parser-Code Generators'
}

{ #category : #'bound variables' }
TViennaVDMFreeVariableCollector >> boundVariables: aViennaNode [
	| boundVars |
	boundVars := Set new.
	self boundVariables: aViennaNode into: boundVars.
	^ boundVars
]

{ #category : #'bound variables' }
TViennaVDMFreeVariableCollector >> boundVariables: aViennaNode into: aSet [
	(aViennaNode isString or: [ aViennaNode isNil ])
		ifFalse: [ 
			| selector |
			selector := ('boundVariables' , aViennaNode label , ':into:') asSymbol.
			(self respondsTo: selector)
				ifTrue: [ self perform: selector with: aViennaNode with: aSet ] ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesAccessFunctionDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesAccessOperationDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesAccessTypeDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesAccessValueDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesAssignmentDefinition: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesBindList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-statements' }
TViennaVDMFreeVariableCollector >> boundVariablesBlockStatement: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesCompositeType: aViennaNode into: aSet [
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
TViennaVDMFreeVariableCollector >> boundVariablesDclStatement: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesDefinitionBlock: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesDocument: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesEqualDefinition: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesEqualDefinitionList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesExplicitFunctionDefinition: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesExplicitOperationDefinition: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesExportDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesExportFunctionsSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesExportModuleSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesExportModuleSignatureAll: aViennaNode into: aSet [
	self notYetImplemented
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesExportTypesSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesField: aViennaNode into: aSet [
	aViennaNode first ifNotNil: [ :name | aSet add: name ]
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesFieldList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesFieldPattern: aViennaNode into: aSet [
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesFieldPatternList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesFunctionDefinition: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesFunctionDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesFunctionExport: aViennaNode into: aSet [
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self freeVariables: aViennaNode third boundVars: aSet into: aSet
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesFunctionImport: aViennaNode into: aSet [
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self boundVariables: aViennaNode third into: aSet.
	aViennaNode fourth ifNotNil: [ :rename | aSet add: rename first ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesFunctionSignature: aViennaNode into: aSet [
	aViennaNode first do: [ :localName | aSet add: localName first ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesFunctionsSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesImportDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesImportDefinitionList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesImportFunctionsSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesImportModuleSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesImportModuleSignatureAll: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesImportOperationsSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesImportTypesSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-statements' }
TViennaVDMFreeVariableCollector >> boundVariablesIndexForLoop: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesInmapType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesLocalDefinition: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesLocalDefinitionList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesMapEnumerationPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesMapMunionPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesMapType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesMapletPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesModule: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesModuleBody: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesMultipleSetBind: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesMultipleTypeBind: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesObjectPattern: aViennaNode into: aSet [
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesOperationDefinition: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesOperationDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesOperationImport: aViennaNode into: aSet [
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self boundVariables: aViennaNode second into: aSet.
	aViennaNode third ifNotNil: [ :rename | aSet add: rename first ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesOperationSignature: aViennaNode into: aSet [
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesOperationType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesOperationsSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesOptionalType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesParameters: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesParametersList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesPartialFunctionType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesPatternIdentifier: aViennaNode into: aSet [
	aViennaNode first ifNotNil: [ :string | aSet add: string ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesPatternList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesProductType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesRecordPattern: aViennaNode into: aSet [
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesRecordTypeDefinition: aViennaNode into: aSet [
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
TViennaVDMFreeVariableCollector >> boundVariablesSeq1Type: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesSeqConcPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesSeqEnumPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesSeqType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-statements' }
TViennaVDMFreeVariableCollector >> boundVariablesSequenceForLoop: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesSetBind: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesSetEnumPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-statements' }
TViennaVDMFreeVariableCollector >> boundVariablesSetForLoop: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesSetType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesSetUnionPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesStateDefinition: aViennaNode into: aSet [
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
TViennaVDMFreeVariableCollector >> boundVariablesTotalFunctionType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesTuplePattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesTypeBind: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesTypeBindList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesTypeDefinition: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesTypeDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesTypeImport: aViennaNode into: aSet [
	aSet add: aViennaNode first.
	aViennaNode second ifNotNil: [ :rename | aSet add: rename first ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesTypeNameExport: aViennaNode into: aSet [
	aSet add: aViennaNode first first
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesTypeStructExport: aViennaNode into: aSet [
	aSet add: aViennaNode first first
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesTypeVariableIdentifier: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesTypeVariableList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesUnionType: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesValueDefinition: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesValueDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesValueImport: aViennaNode into: aSet [
	aSet add: aViennaNode first.
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesValueSignature: aViennaNode into: aSet [
	aViennaNode first do: [ :localName | aSet add: localName first ].
	self freeVariables: aViennaNode second boundVars: aSet into: aSet
]

{ #category : #'bound variables-interfaces' }
TViennaVDMFreeVariableCollector >> boundVariablesValuesSignature: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'free variables' }
TViennaVDMFreeVariableCollector >> freeVariables: aViennaNode boundVars: aSet into: free [
	(aViennaNode isString or: [ aViennaNode isNil ])
		ifFalse: [ 
			| selector |
			selector := ('freeVariables' , aViennaNode label , ':boundVars:into:') asSymbol.
			(self respondsTo: selector)
				ifTrue: [ 
					self
						perform: selector
						with: aViennaNode
						with: aSet
						with: free ]
				ifFalse: [ aViennaNode do: [ :node | self freeVariables: node boundVars: aSet into: free ] ] ]
]

{ #category : #'free variables' }
TViennaVDMFreeVariableCollector >> freeVariables: aViennaNode env: aDictionary [
	| freeVars |
	freeVars := Set new: 16.
	self freeVariables: aViennaNode boundVars: aDictionary keys asSet into: freeVars.
	^ freeVars
]

{ #category : #'free variables-statements' }
TViennaVDMFreeVariableCollector >> freeVariablesAssignmentDefinition: aViennaNode boundVars: boundVars into: freeVars [
	| binds |
	binds := boundVars copy.
	self boundVariables: aViennaNode into: binds.
	aViennaNode do: [ :node | self freeVariables: node boundVars: binds into: freeVars ]
]

{ #category : #'free variables-statements' }
TViennaVDMFreeVariableCollector >> freeVariablesBlockStatement: aViennaNode boundVars: boundVars into: freeVars [
	| binds |
	binds := boundVars copy.
	aViennaNode
		do: [ :node | 
			node label = 'DclStatement'
				ifTrue: [ self boundVariables: node into: binds ] ].
	aViennaNode do: [ :node | self freeVariables: node boundVars: binds into: freeVars ]
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesCasesExpressionAlternative: aViennaNode boundVars: boundVars into: freeVars [
	| binds patterns expressionBody |
	binds := boundVars copy.
	patterns := aViennaNode first.
	expressionBody := aViennaNode second.
	self freeVariables: patterns boundVars: binds into: freeVars.
	self boundVariables: patterns into: binds.
	self freeVariables: expressionBody boundVars: binds into: freeVars
]

{ #category : #'free variables-statements' }
TViennaVDMFreeVariableCollector >> freeVariablesCasesStatementAlternative: aViennaNode boundVars: boundVars into: freeVars [
	| binds patterns bodyStatement |
	binds := boundVars copy.
	patterns := aViennaNode first.
	bodyStatement := aViennaNode second.
	self freeVariables: patterns boundVars: binds into: freeVars.
	self boundVariables: patterns into: binds.
	self freeVariables: bodyStatement boundVars: binds into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesDefExpression: aViennaNode boundVars: boundVars into: freeVars [
	| binds equalDefinitionList bodyExpression |
	binds := boundVars copy.
	equalDefinitionList := aViennaNode first.
	bodyExpression := aViennaNode second.
	self boundVariables: equalDefinitionList into: binds.
	self freeVariables: equalDefinitionList boundVars: binds into: freeVars.
	self freeVariables: bodyExpression boundVars: binds into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesExists1Expression: aViennaNode boundVars: boundVars into: freeVars [
	| binds typeBind expressionBody |
	binds := boundVars copy.
	typeBind := aViennaNode first.
	expressionBody := aViennaNode second.
	self freeVariables: typeBind boundVars: binds into: freeVars.
	self boundVariables: typeBind into: binds.
	self freeVariables: expressionBody boundVars: binds into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesExistsExpression: aViennaNode boundVars: boundVars into: freeVars [
	| binds bindList expressionBody |
	binds := boundVars copy.
	bindList := aViennaNode first.
	expressionBody := aViennaNode second.
	self freeVariables: bindList boundVars: binds into: freeVars.
	self boundVariables: bindList into: binds.
	self freeVariables: expressionBody boundVars: binds into: freeVars
]

{ #category : #'free variables-definitions' }
TViennaVDMFreeVariableCollector >> freeVariablesField: aViennaNode boundVars: boundVars into: freeVars [
	| type |
	type := aViennaNode third.
	self freeVariables: type boundVars: boundVars into: freeVars
]

{ #category : #'free variables-statements' }
TViennaVDMFreeVariableCollector >> freeVariablesFieldReference: aViennaNode boundVars: boundVars into: freeVars [
	self freeVariables: aViennaNode first boundVars: boundVars into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesFieldSelect: aViennaNode boundVars: boundVars into: freeVars [
	self freeVariables: aViennaNode first boundVars: boundVars into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesForallExpression: aViennaNode boundVars: boundVars into: freeVars [
	| binds bindList expressionBody |
	binds := boundVars copy.
	bindList := aViennaNode first.
	expressionBody := aViennaNode second.
	self freeVariables: bindList boundVars: binds into: freeVars.
	self boundVariables: bindList into: binds.
	self freeVariables: expressionBody boundVars: binds into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesGlobalName: aViennaNode boundVars: boundVars into: freeVars [
	| name |
	name := aViennaNode first , '`' , aViennaNode second.
	(boundVars includes: name)
		ifFalse: [ freeVars add: name ]
]

{ #category : #'free variables-statements' }
TViennaVDMFreeVariableCollector >> freeVariablesIndexForLoop: aViennaNode boundVars: boundVars into: freeVars [
	| binds |
	binds := boundVars copy.
	self boundVariables: aViennaNode into: binds.
	aViennaNode do: [ :node | self freeVariables: node boundVars: binds into: freeVars ]
]

{ #category : #'free variables-definitions' }
TViennaVDMFreeVariableCollector >> freeVariablesInvariantInitialFunction: aViennaNode boundVars: boundVars into: freeVars [
	| pattern expression binds |
	pattern := aViennaNode first.
	expression := aViennaNode second.
	binds := boundVars copy.
	self boundVariables: pattern into: binds.
	self freeVariables: expression boundVars: binds into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesIotaExpression: aViennaNode boundVars: boundVars into: freeVars [
	| binds typeBind expressionBody |
	binds := boundVars copy.
	typeBind := aViennaNode first.
	expressionBody := aViennaNode second.
	self freeVariables: typeBind boundVars: binds into: freeVars.
	self boundVariables: typeBind into: binds.
	self freeVariables: expressionBody boundVars: binds into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesLambdaExpression: aViennaNode boundVars: boundVars into: freeVars [
	| binds typeBindList expressionBody |
	binds := boundVars copy.
	typeBindList := aViennaNode first.
	expressionBody := aViennaNode second.
	self freeVariables: typeBindList boundVars: binds into: freeVars.
	self boundVariables: typeBindList into: binds.
	self freeVariables: expressionBody boundVars: binds into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesLetBeExpression: aViennaNode boundVars: boundVars into: freeVars [
	| binds multipleBind guardExpression bodyExpression |
	binds := boundVars copy.
	multipleBind := aViennaNode first.
	guardExpression := aViennaNode second.
	bodyExpression := aViennaNode third.
	self freeVariables: multipleBind boundVars: binds into: freeVars.
	self boundVariables: multipleBind into: binds.
	self freeVariables: guardExpression boundVars: binds into: freeVars.
	self freeVariables: bodyExpression boundVars: binds into: freeVars
]

{ #category : #'free variables-statements' }
TViennaVDMFreeVariableCollector >> freeVariablesLetBeStatement: aViennaNode boundVars: boundVars into: freeVars [
	| binds multipleBind guardExpression bodyStatement |
	binds := boundVars copy.
	multipleBind := aViennaNode first.
	guardExpression := aViennaNode second.
	bodyStatement := aViennaNode third.
	self freeVariables: multipleBind boundVars: binds into: freeVars.
	self boundVariables: multipleBind into: binds.
	self freeVariables: guardExpression boundVars: binds into: freeVars.
	self freeVariables: bodyStatement boundVars: binds into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesLetExpression: aViennaNode boundVars: boundVars into: freeVars [
	| binds localDefinitionList bodyExpression |
	binds := boundVars copy.
	localDefinitionList := aViennaNode first.
	bodyExpression := aViennaNode second.
	self boundVariables: localDefinitionList into: binds.
	self freeVariables: localDefinitionList boundVars: binds into: freeVars.
	self freeVariables: bodyExpression boundVars: binds into: freeVars
]

{ #category : #'free variables-statements' }
TViennaVDMFreeVariableCollector >> freeVariablesLetStatement: aViennaNode boundVars: boundVars into: freeVars [
	| binds localDefinitionList bodyStatement |
	binds := boundVars copy.
	localDefinitionList := aViennaNode first.
	bodyStatement := aViennaNode second.
	self boundVariables: localDefinitionList into: binds.
	self freeVariables: localDefinitionList boundVars: binds into: freeVars.
	self freeVariables: bodyStatement boundVars: binds into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesLocalName: aViennaNode boundVars: boundVars into: freeVars [
	| name |
	name := aViennaNode first.
	(boundVars includes: name)
		ifFalse: [ freeVars add: name ]
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesMapComprehension: aViennaNode boundVars: boundVars into: freeVars [
	| binds keyExpression valueExpression bindList guardExpression |
	binds := boundVars copy.
	keyExpression := aViennaNode first.
	valueExpression := aViennaNode second.
	bindList := aViennaNode third.
	guardExpression := aViennaNode fourth.
	self freeVariables: bindList boundVars: binds into: freeVars.
	self boundVariables: bindList into: binds.
	self freeVariables: keyExpression boundVars: binds into: freeVars.
	self freeVariables: valueExpression boundVars: binds into: freeVars.
	self freeVariables: guardExpression boundVars: binds into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesRecordModifier: aViennaNode boundVars: boundVars into: freeVars [
	| record mapletList |
	record := aViennaNode first.
	mapletList := aViennaNode second.
	self freeVariables: record boundVars: boundVars into: freeVars.
	mapletList
		do: [ :maplet | 
			| valueExpression |
			valueExpression := maplet second.
			self freeVariables: valueExpression boundVars: boundVars into: freeVars ]
]

{ #category : #'free variables-definitions' }
TViennaVDMFreeVariableCollector >> freeVariablesRecordTypeDefinitions: aViennaNode boundVars: boundVars into: freeVars [
	| binds identifier fieldList inv |
	binds := boundVars copy.
	identifier := aViennaNode first.
	fieldList := aViennaNode second.
	inv := aViennaNode third.
	binds add: identifier.
	self freeVariables: fieldList boundVars: binds into: freeVars.
	self freeVariables: inv boundVars: binds into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesSequenceComprehension: aViennaNode boundVars: boundVars into: freeVars [
	| binds expression bindList guardExpression |
	binds := boundVars copy.
	expression := aViennaNode first.
	bindList := aViennaNode second.
	guardExpression := aViennaNode third.
	self freeVariables: bindList boundVars: binds into: freeVars.
	self boundVariables: bindList into: binds.
	self freeVariables: expression boundVars: binds into: freeVars.
	self freeVariables: guardExpression boundVars: binds into: freeVars
]

{ #category : #'free variables-statements' }
TViennaVDMFreeVariableCollector >> freeVariablesSequenceForLoop: aViennaNode boundVars: boundVars into: freeVars [
	| binds |
	binds := boundVars copy.
	self boundVariables: aViennaNode into: binds.
	aViennaNode do: [ :node | self freeVariables: node boundVars: binds into: freeVars ]
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesSetComprehension: aViennaNode boundVars: boundVars into: freeVars [
	| binds expression bindList guardExpression |
	binds := boundVars copy.
	expression := aViennaNode first.
	bindList := aViennaNode second.
	guardExpression := aViennaNode third.
	self freeVariables: bindList boundVars: binds into: freeVars.
	self boundVariables: bindList into: binds.
	self freeVariables: expression boundVars: binds into: freeVars.
	self freeVariables: guardExpression boundVars: binds into: freeVars
]

{ #category : #'free variables-statements' }
TViennaVDMFreeVariableCollector >> freeVariablesSetForLoop: aViennaNode boundVars: boundVars into: freeVars [
	| binds |
	binds := boundVars copy.
	self boundVariables: aViennaNode into: binds.
	aViennaNode do: [ :node | self freeVariables: node boundVars: binds into: freeVars ]
]

{ #category : #'free variables-definitions' }
TViennaVDMFreeVariableCollector >> freeVariablesStateDefinition: aViennaNode boundVars: boundVars into: aSet [
	| binds |
	binds := boundVars copy.
	self boundVariables: aViennaNode into: binds.
	aViennaNode do: [ :node | self freeVariables: node boundVars: binds into: aSet ]
]
