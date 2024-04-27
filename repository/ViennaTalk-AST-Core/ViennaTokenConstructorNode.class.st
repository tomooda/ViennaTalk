Class {
	#name : #ViennaTokenConstructorNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaTokenConstructorNode class >> expression: aViennaExpressionNode [

	^ (self new: 1)
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaTokenConstructorNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaTokenConstructorNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaTokenConstructorNode >> formatWith: aViennaAbstractFormatter [

	| expression |
	expression := aViennaAbstractFormatter format: self expression.
	^ (aViennaAbstractFormatter keyword: 'mk_')
	  , (aViennaAbstractFormatter typeName: 'token') , '('
	  , ((aViennaAbstractFormatter needsIndent: expression)
			   ifTrue: [
				   String cr , aViennaAbstractFormatter indent
				   , (aViennaAbstractFormatter indentString: expression) ]
			   ifFalse: [ expression ]) , ')'
]

{ #category : #private }
ViennaTokenConstructorNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaTokenConstructorNode >> isViennaTokenConstructorNode [

	^ true
]

{ #category : #accessing }
ViennaTokenConstructorNode >> label [

	^ 'TokenConstructor'
]

{ #category : #typechecking }
ViennaTokenConstructorNode >> maximalType [

	self expression typecheck.
	^ ViennaType token
]
