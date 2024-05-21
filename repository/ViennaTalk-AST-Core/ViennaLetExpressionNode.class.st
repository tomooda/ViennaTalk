Class {
	#name : 'ViennaLetExpressionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaLetExpressionNode class >> localDefinitionList: aViennaLocalDefinitionListNode body: aViennaExpressionNode [

	^ self
		  localDefinitionList: aViennaLocalDefinitionListNode
		  expression: aViennaExpressionNode
]

{ #category : 'instance creation' }
ViennaLetExpressionNode class >> localDefinitionList: aViennaLocalDefinitionListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  localDefinitionList: aViennaLocalDefinitionListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : 'accessing' }
ViennaLetExpressionNode >> body [

	^ self expression
]

{ #category : 'accessing' }
ViennaLetExpressionNode >> body: aViennaExpressionNode [

	^ self expression: aViennaExpressionNode
]

{ #category : 'accessing-definitions' }
ViennaLetExpressionNode >> definitionOfLocalName: aString [

	self localDefinitionList do: [ :def |
		def isViennaValueDefinitionNode ifTrue: [
			def pattern
				allDescendantsSuchThat: [ :n |
				n isViennaPatternIdentifierNode: aString ]
				do: [ :n | ^ n ] ].
		(def isViennaFunctionDefinitionNode: aString) ifTrue: [ ^ def ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : 'accessing' }
ViennaLetExpressionNode >> expression [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaLetExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : 'accessing-definitions' }
ViennaLetExpressionNode >> findResolverForIdentifier: aString [

	^ (self localDefinitionList bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaLetExpressionNode >> formatWith: aViennaAbstractFormatter [

	| localDefinitionList expression |
	localDefinitionList := aViennaAbstractFormatter format:
		                       self localDefinitionList.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'let')
				   insertCrIfNeeded: localDefinitionList)
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'in')
				   insertCrIfNeeded: expression)
]

{ #category : 'private' }
ViennaLetExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet
	                    , self localDefinitionList uniqueBoundIdentifiers.
	self localDefinitionList
		freeIdentifiersExcept: boundIdentifiers
		do: aBlock.
	self expression freeIdentifiersExcept: boundIdentifiers do: aBlock
]

{ #category : 'testing' }
ViennaLetExpressionNode >> hasScope [

	^ true
]

{ #category : 'accessing' }
ViennaLetExpressionNode >> isViennaLetExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaLetExpressionNode >> label [

	^ 'LetExpression'
]

{ #category : 'accessing' }
ViennaLetExpressionNode >> localDefinitionList [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaLetExpressionNode >> localDefinitionList: aViennaLocalDefinitionListNode [

	self at: 1 put: aViennaLocalDefinitionListNode
]

{ #category : 'enumerating' }
ViennaLetExpressionNode >> localDefinitionsDo: aBlock [

	self localDefinitionList do: aBlock
]

{ #category : 'accessing-definitions' }
ViennaLetExpressionNode >> lookupIdentifier: aString [

	self localDefinitionList do: [ :localDefinition |
		(localDefinition bindsIdentifier: aString) ifTrue: [
			^ localDefinition ] ].
	^ nil
]

{ #category : 'typechecking' }
ViennaLetExpressionNode >> maximalType [

	self localDefinitionList typecheck.
	^ self body typecheck
]

{ #category : 'typechecking' }
ViennaLetExpressionNode >> maximalType: aViennaType [

	self localDefinitionList typecheck.
	self expression maximalType: aViennaType.
	super maximalType: aViennaType
]

{ #category : 'pretty printing' }
ViennaLetExpressionNode >> operatorPrecedence [

	^ 10
]
