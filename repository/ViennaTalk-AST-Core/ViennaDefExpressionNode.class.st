Class {
	#name : 'ViennaDefExpressionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaDefExpressionNode class >> equalDefinitionList: aViennaEqualDefinitionListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  equalDefinitionList: aViennaEqualDefinitionListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : 'accessing-definitions' }
ViennaDefExpressionNode >> definitionOfLocalName: aString [

	self patternOrBindReverseDo: [ :patternOrBind |
		patternOrBind
			allDescendantsSuchThat: [ :n | n isViennaPatternIdentifierNode: aString ]
			do: [ :n | ^ n ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : 'accessing-definitions' }
ViennaDefExpressionNode >> definitionOfLocalName: aString for: aViennaNode [

	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : 'accessing' }
ViennaDefExpressionNode >> equalDefinitionList [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaDefExpressionNode >> equalDefinitionList: aViennaEqualDefinitionListNode [

	self at: 1 put: aViennaEqualDefinitionListNode
]

{ #category : 'enumerating' }
ViennaDefExpressionNode >> equalDefinitionListReverseDo: aBlock [

	self equalDefinitionList reverseDo: aBlock
]

{ #category : 'accessing' }
ViennaDefExpressionNode >> expression [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaDefExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : 'accessing-definitions' }
ViennaDefExpressionNode >> findResolverForIdentifier: aString [

	^ (self equalDefinitionList bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaDefExpressionNode >> formatWith: aViennaAbstractFormatter [

	| defs expression |
	defs := aViennaAbstractFormatter format: self equalDefinitionList.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'def')
				   insertCrIfNeeded: defs)
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'in')
				   insertCrIfNeeded: expression)
]

{ #category : 'private' }
ViennaDefExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self equalDefinitionList freeIdentifiersExcept: aSet do: aBlock.
	self expression
		freeIdentifiersExcept:
		aSet , self equalDefinitionList uniqueBoundIdentifiers
		do: aBlock
]

{ #category : 'accessing' }
ViennaDefExpressionNode >> isViennaDefExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaDefExpressionNode >> label [

	^ 'DefExpression'
]

{ #category : 'accessing-definitions' }
ViennaDefExpressionNode >> lookupIdentifier: aString [

	self equalDefinitionList do: [ :equalDefinition |
		(equalDefinition bindsIdentifier: aString) ifTrue: [
			^ equalDefinition ] ].
	^ nil
]

{ #category : 'typechecking' }
ViennaDefExpressionNode >> maximalType [

	self equalDefinitionList do: [ :equalDef | equalDef typecheck ].
	^ self expression typecheck
]

{ #category : 'typechecking' }
ViennaDefExpressionNode >> maximalType: aViennaType [

	self expression maximalType: aViennaType.
	super maximalType: aViennaType
]

{ #category : 'pretty printing' }
ViennaDefExpressionNode >> operatorPrecedence [

	^ 10
]

{ #category : 'enumerating' }
ViennaDefExpressionNode >> patternOrBindReverseDo: aBlock [

	self equalDefinitionListReverseDo: [ :equalDefinition |
		aBlock value: equalDefinition patternOrBind ]
]
