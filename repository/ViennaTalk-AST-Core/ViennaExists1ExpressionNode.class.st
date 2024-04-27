Class {
	#name : #ViennaExists1ExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaExists1ExpressionNode class >> bind: aViennaBindNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  bind: aViennaBindNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaExists1ExpressionNode >> bind [

	^ self at: 1
]

{ #category : #accessing }
ViennaExists1ExpressionNode >> bind: aViennaBindNode [

	self at: 1 put: aViennaBindNode
]

{ #category : #'accessing-definitions' }
ViennaExists1ExpressionNode >> definitionOfLocalName: aString [

	self pattern
		allDescendantsSuchThat: [ :n | n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaExists1ExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaExists1ExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'accessing-definitions' }
ViennaExists1ExpressionNode >> findResolverForIdentifier: aString [

	^ (self pattern bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaExists1ExpressionNode >> formatWith: aViennaAbstractFormatter [

	| bind expression |
	bind := aViennaAbstractFormatter format: self bind.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter
				   indentString: aViennaAbstractFormatter exists1
				   insertCrIfNeeded: bind ++ ' ' ++ aViennaAbstractFormatter dot)
		  insertCrIfNeeded: expression
]

{ #category : #private }
ViennaExists1ExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self bind freeIdentifiersExcept: aSet do: aBlock.
	self expression
		freeIdentifiersExcept: aSet , self bind uniqueBoundIdentifiers
		do: aBlock
]

{ #category : #testing }
ViennaExists1ExpressionNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaExists1ExpressionNode >> isViennaExists1ExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaExists1ExpressionNode >> label [

	^ 'Exists1Expression'
]

{ #category : #'accessing-definitions' }
ViennaExists1ExpressionNode >> lookupIdentifier: aString [

	^ (self pattern bindsIdentifier: aString)
		  ifTrue: [ self bind ]
		  ifFalse: [ nil ]
]

{ #category : #typechecking }
ViennaExists1ExpressionNode >> maximalType [

	self bind typecheck.
	^ self expression typecheck: ViennaType bool
]

{ #category : #'pretty printing' }
ViennaExists1ExpressionNode >> operatorPrecedence [

	^ 10
]

{ #category : #accessing }
ViennaExists1ExpressionNode >> pattern [

	^ self bind pattern
]
