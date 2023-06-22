Class {
	#name : #ViennaIotaExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaIotaExpressionNode class >> bind: aViennaBindNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  bind: aViennaBindNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaIotaExpressionNode >> bind [

	^ self at: 1
]

{ #category : #accessing }
ViennaIotaExpressionNode >> bind: aViennaBindNode [

	self at: 1 put: aViennaBindNode
]

{ #category : #'accessing-definitions' }
ViennaIotaExpressionNode >> definitionOfLocalName: aString [

	self pattern
		allDescendantsSuchThat: [ :n | n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaIotaExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaIotaExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaIotaExpressionNode >> formatWith: aViennaAbstractFormatter [

	| bind expression |
	bind := aViennaAbstractFormatter format: self bind.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: aViennaAbstractFormatter iota , ' ' , bind , ' '
			  , aViennaAbstractFormatter dot
		  insertCrIfNeeded: expression
]

{ #category : #private }
ViennaIotaExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self bind freeIdentifiersExcept: aSet do: aBlock.
	self expression
		freeIdentifiersExcept: aSet , self bind uniqueBoundIdentifiers
		do: aBlock
]

{ #category : #testing }
ViennaIotaExpressionNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaIotaExpressionNode >> isViennaIotaExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaIotaExpressionNode >> label [

	^ 'IotaExpression'
]

{ #category : #'pretty printing' }
ViennaIotaExpressionNode >> operatorPrecedence [

	^ 30
]

{ #category : #accessing }
ViennaIotaExpressionNode >> pattern [

	^ self bind pattern
]

{ #category : #testing }
ViennaIotaExpressionNode >> resolveIdentifier: aString [

	^ (self bind bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super resolveIdentifier: aString ]
]
