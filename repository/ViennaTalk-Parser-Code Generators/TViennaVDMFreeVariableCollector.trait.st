Trait {
	#name : #TViennaVDMFreeVariableCollector,
	#traits : 'TViennaVDMBoundVariableCollector',
	#classTraits : 'TViennaVDMBoundVariableCollector classTrait',
	#category : 'ViennaTalk-Parser-Code Generators'
}

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
