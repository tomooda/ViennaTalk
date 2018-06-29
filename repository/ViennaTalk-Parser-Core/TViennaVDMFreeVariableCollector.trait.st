Trait {
	#name : #TViennaVDMFreeVariableCollector,
	#category : 'ViennaTalk-Parser-Core'
}

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
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesAccessOperationDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesAccessTypeDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesAccessValueDefinition: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesAssignmentDefinition: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesBindList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesDefinitionBlock: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesDocument: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesEqualDefinition: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesEqualDefinitionList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesExplicitFunctionDefinition: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesExplicitOperationDefinition: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesField: aViennaNode into: aSet [
	aViennaNode first ifNotNil: [ :name | aSet add: name ]
]

{ #category : #'bound variables-types' }
TViennaVDMFreeVariableCollector >> boundVariablesFieldList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
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
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesLocalDefinition: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesLocalDefinitionList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesMapEnumerationPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesMapMunionPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesMapletPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesModule: aViennaNode into: aSet [
	aSet add: aViennaNode first
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
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesParameters: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesParametersList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesPatternIdentifier: aViennaNode into: aSet [
	aViennaNode first ifNotNil: [ :string | aSet add: string ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesPatternList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesRecordPattern: aViennaNode into: aSet [
	self boundVariables: aViennaNode second into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesSeqConcPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesSeqEnumPattern: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: node into: aSet ]
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesSetBind: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-patterns and binds' }
TViennaVDMFreeVariableCollector >> boundVariablesSetEnumPattern: aViennaNode into: aSet [
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
	stateFieldList boundVariables: aViennaNode into: aSet
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
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesTypeVariableIdentifier: aViennaNode into: aSet [
	aSet add: aViennaNode first
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesTypeVariableList: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesValueDefinition: aViennaNode into: aSet [
	self boundVariables: aViennaNode first into: aSet
]

{ #category : #'bound variables-definitions' }
TViennaVDMFreeVariableCollector >> boundVariablesValueDefinitions: aViennaNode into: aSet [
	aViennaNode do: [ :node | self boundVariables: aViennaNode into: aSet ]
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
	self freeVariables: aViennaNode env: aDictionary keys asSet into: freeVars.
	^ freeVars asArray
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
TViennaVDMFreeVariableCollector >> freeVariablesLambda: aViennaNode boundVars: boundVars into: freeVars [
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

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesLetExpression: aViennaNode boundVars: boundVars into: freeVars [
	| binds localDefinitionList bodyExpression |
	binds := boundVars copy.
	localDefinitionList := aViennaNode first.
	bodyExpression := aViennaNode second.
	self freeVariables: localDefinitionList boundVars: binds into: freeVars.
	self boundVariables: bodyExpression into: binds.
	self freeVariables: bodyExpression boundVars: binds into: freeVars
]

{ #category : #'free variables-expressions' }
TViennaVDMFreeVariableCollector >> freeVariablesLocalName: aViennaNode boundVars: boundVars into: freeVars [
	| name |
	name := aViennaNode first.
	(boundVars includes: name)
		ifFalse: [ freeVars add: name ]
]

{ #category : #private }
TViennaVDMFreeVariableCollector >> freeVariablesLocalScope: aViennaNode boundVars: boundVars into: freeVars [
	| binds |
	binds := boundVars copy.
	aViennaNode do: [ :node | self freeVariables: node boundVars: binds into: freeVars ]
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
TViennaVDMFreeVariableCollector >> freeVariablesRecordConstructor: aViennaNode boundVars: boundVars into: freeVars [
	| constructor expressionList |
	constructor := aViennaNode first.
	expressionList := aViennaNode second.
	(boundVars includes: constructor)
		ifFalse: [ freeVars add: aViennaNode first ].
	self freeVariables: expressionList boundVars: boundVars into: freeVars
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
