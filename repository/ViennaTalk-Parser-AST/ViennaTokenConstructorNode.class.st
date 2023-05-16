Class {
	#name : #ViennaTokenConstructorNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
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
	^ 'mk_token(' , ((aViennaAbstractFormatter needsIndent: expression)
		   ifTrue: [
			   String cr , aViennaAbstractFormatter indent
			   , (aViennaAbstractFormatter indentString: expression) ]
		   ifFalse: [ expression ]) , ')'
]

{ #category : #accessing }
ViennaTokenConstructorNode >> label [

	^ 'TokenConstructor'
]
