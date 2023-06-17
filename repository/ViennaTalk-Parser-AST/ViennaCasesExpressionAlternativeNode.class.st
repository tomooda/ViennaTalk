Class {
	#name : #ViennaCasesExpressionAlternativeNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaCasesExpressionAlternativeNode class >> patternList: aViennaPatternListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  patternList: aViennaPatternListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaCasesExpressionAlternativeNode >> definitionOfLocalName: aString [

	self patternList
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaCasesExpressionAlternativeNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaCasesExpressionAlternativeNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaCasesExpressionAlternativeNode >> formatWith: aViennaAbstractFormatter [

	| patternList expression |
	patternList := aViennaAbstractFormatter format: self patternList.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: patternList , ' ' , aViennaAbstractFormatter arrow
		  insertCrIfNeeded: expression
]

{ #category : #testing }
ViennaCasesExpressionAlternativeNode >> isViennaCasesExpressionAlternativeNode [

	^ true
]

{ #category : #accessing }
ViennaCasesExpressionAlternativeNode >> label [

	^ 'CasesExpressionAlternative'
]

{ #category : #accessing }
ViennaCasesExpressionAlternativeNode >> patternList [

	^ self at: 1
]

{ #category : #accessing }
ViennaCasesExpressionAlternativeNode >> patternList: aViennaPatternListNode [

	self at: 1 put: aViennaPatternListNode
]
