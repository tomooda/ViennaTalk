Class {
	#name : 'ViennaCasesExpressionAlternativeNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaCasesExpressionAlternativeNode class >> patternList: aViennaPatternListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  patternList: aViennaPatternListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : 'private' }
ViennaCasesExpressionAlternativeNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'accessing-definitions' }
ViennaCasesExpressionAlternativeNode >> definitionOfLocalName: aString [

	self patternList
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : 'accessing' }
ViennaCasesExpressionAlternativeNode >> expression [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaCasesExpressionAlternativeNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : 'private' }
ViennaCasesExpressionAlternativeNode >> findResolverForIdentifier: aString [

	^ (self patternList bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaCasesExpressionAlternativeNode >> formatWith: aViennaAbstractFormatter [

	| patternList expression |
	patternList := aViennaAbstractFormatter format: self patternList.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: patternList ++ ' ' ++ aViennaAbstractFormatter arrow
		  insertCrIfNeeded: expression
]

{ #category : 'private' }
ViennaCasesExpressionAlternativeNode >> freeIdentifiersExcept: aSet do: aBlock [

	self patternList freeIdentifiersExcept: aSet do: aBlock.
	self expression
		freeIdentifiersExcept:
		aSet , self patternList uniqueBoundIdentifiers
		do: aBlock
]

{ #category : 'testing' }
ViennaCasesExpressionAlternativeNode >> hasScope [

	^ true
]

{ #category : 'testing' }
ViennaCasesExpressionAlternativeNode >> isViennaCasesExpressionAlternativeNode [

	^ true
]

{ #category : 'accessing' }
ViennaCasesExpressionAlternativeNode >> label [

	^ 'CasesExpressionAlternative'
]

{ #category : 'private' }
ViennaCasesExpressionAlternativeNode >> lookupIdentifier: aString [

	^ (self bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ nil ]
]

{ #category : 'typechecking' }
ViennaCasesExpressionAlternativeNode >> maximalType [

	^ self expression typecheck
]

{ #category : 'accessing' }
ViennaCasesExpressionAlternativeNode >> patternList [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaCasesExpressionAlternativeNode >> patternList: aViennaPatternListNode [

	self at: 1 put: aViennaPatternListNode
]
