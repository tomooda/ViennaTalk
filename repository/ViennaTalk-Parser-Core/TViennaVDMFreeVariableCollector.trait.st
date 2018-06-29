Trait {
	#name : #TViennaVDMFreeVariableCollector,
	#traits : 'TViennaVDMBoundVariableCollector',
	#classTraits : 'TViennaVDMBoundVariableCollector classTrait',
	#category : 'ViennaTalk-Parser-Core'
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
