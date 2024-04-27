Class {
	#name : #ViennaInvariantInitialFunctionNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaInvariantInitialFunctionNode class >> pattern: aViennaPatternNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  pattern: aViennaPatternNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #private }
ViennaInvariantInitialFunctionNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'accessing-definitions' }
ViennaInvariantInitialFunctionNode >> definitionOfLocalName: aString [

	self pattern
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaInvariantInitialFunctionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaInvariantInitialFunctionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'accessing-definitions' }
ViennaInvariantInitialFunctionNode >> findResolverForIdentifier: aString [

	^ (self pattern bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaInvariantInitialFunctionNode >> formatWith: aViennaAbstractFormatter [

	| pattern expression |
	pattern := aViennaAbstractFormatter format: self pattern.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: pattern , ' =='
		  insertCrIfNeeded: expression
]

{ #category : #private }
ViennaInvariantInitialFunctionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self pattern freeIdentifiersExcept: aSet do: aBlock.
	self expression
		freeIdentifiersExcept: aSet , self pattern uniqueBoundIdentifiers
		do: aBlock
]

{ #category : #testing }
ViennaInvariantInitialFunctionNode >> hasScope [

	^ true
]

{ #category : #testing }
ViennaInvariantInitialFunctionNode >> isViennaInvariantInitialFunctionNode [

	^ true
]

{ #category : #accessing }
ViennaInvariantInitialFunctionNode >> label [

	^ 'InvariantInitialFunction'
]

{ #category : #'accessing-definitions' }
ViennaInvariantInitialFunctionNode >> lookupIdentifier: aString [

	^ (self pattern bindsIdentifier: aString) ifTrue: [ self pattern ]
]

{ #category : #typechecking }
ViennaInvariantInitialFunctionNode >> maximalType [

	self pattern typecheck.
	self expression typecheck: ViennaType bool.
	^ self pattern typecheck
]

{ #category : #typechecking }
ViennaInvariantInitialFunctionNode >> maximalType: aViennaType [

	self pattern maximalType: aViennaType
]

{ #category : #accessing }
ViennaInvariantInitialFunctionNode >> pattern [

	^ self at: 1
]

{ #category : #accessing }
ViennaInvariantInitialFunctionNode >> pattern: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]
