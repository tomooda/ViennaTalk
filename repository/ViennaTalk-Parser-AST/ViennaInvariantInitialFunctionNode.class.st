Class {
	#name : #ViennaInvariantInitialFunctionNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaInvariantInitialFunctionNode class >> pattern: aViennaPatternNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  pattern: aViennaPatternNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #private }
ViennaInvariantInitialFunctionNode >> boundIdentifiersInto: aSet [

	
]

{ #category : #accessing }
ViennaInvariantInitialFunctionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaInvariantInitialFunctionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
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

{ #category : #accessing }
ViennaInvariantInitialFunctionNode >> pattern [

	^ self at: 1
]

{ #category : #accessing }
ViennaInvariantInitialFunctionNode >> pattern: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]
