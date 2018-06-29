Trait {
	#name : #TViennaVDMBoundVariableCollector,
	#category : 'ViennaTalk-Parser-Core'
}

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

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesMapletPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesModule: aViennaNode into: aSet [
	aSet add: aViennaNode first
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

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesParameters: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesParametersList: aViennaNode into: aSet [
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

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesRecordPattern: aViennaNode into: aSet [
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesSeqConcPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesSeqEnumPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesSetBind: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMBoundVariableCollector >> boundVariablesSetEnumPattern: aViennaNode into: aSet [
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

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeVariableIdentifier: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-definitions' }
TViennaVDMBoundVariableCollector >> boundVariablesTypeVariableList: aViennaNode into: aSet [
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
