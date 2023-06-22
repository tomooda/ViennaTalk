Class {
	#name : #ViennaMultipleBindQuantifierNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaMultipleBindQuantifierNode class >> isAbstract [

	^ self = ViennaMultipleBindQuantifierNode
]

{ #category : #accessing }
ViennaMultipleBindQuantifierNode >> bindList [

	^ self at: 1
]

{ #category : #accessing }
ViennaMultipleBindQuantifierNode >> bindList: aViennaBindListNode [

	self at: 1 put: aViennaBindListNode
]

{ #category : #'accessing-definitions' }
ViennaMultipleBindQuantifierNode >> definitionOfLocalName: aString [

	self patternsDo: [ :pattern |
		pattern
			allDescendantsSuchThat: [ :n | n isViennaPatternIdentifierNode: aString ]
			do: [ :n | ^ n ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaMultipleBindQuantifierNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaMultipleBindQuantifierNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #private }
ViennaMultipleBindQuantifierNode >> freeIdentifiersExcept: aSet do: aBlock [

	self bindList freeIdentifiersExcept: aSet do: aBlock.
	self expression
		freeIdentifiersExcept: aSet , self bindList uniqueBoundIdentifiers
		do: aBlock
]

{ #category : #testing }
ViennaMultipleBindQuantifierNode >> hasScope [

	^ true
]

{ #category : #testing }
ViennaMultipleBindQuantifierNode >> isViennaMultipleBindQuantifierNode [

	^ true
]

{ #category : #enumerating }
ViennaMultipleBindQuantifierNode >> multipleBindsDo: aBlock [

	self bindList do: aBlock
]

{ #category : #enumerating }
ViennaMultipleBindQuantifierNode >> patternsDo: aBlock [

	self multipleBindsDo: [ :multipleBind |
		multipleBind patternsDo: aBlock ]
]

{ #category : #'accessing-definitions' }
ViennaMultipleBindQuantifierNode >> resolveIdentifier: aString [

	^ (self bindList bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super resolveIdentifier: aString ]
]
