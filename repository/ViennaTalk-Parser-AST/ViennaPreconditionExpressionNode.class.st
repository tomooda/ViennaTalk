Class {
	#name : #ViennaPreconditionExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaPreconditionExpressionNode >> formatWith: aViennaAbstractFormatter [

	| expressions |
	expressions := aViennaAbstractFormatter formatAll: self.
	^ 'pre_(' , ((aViennaAbstractFormatter anyNeedsIndent: expressions)
		   ifTrue: [
			   aViennaAbstractFormatter
				   join: ',' , String cr , aViennaAbstractFormatter indent
				   withAll: (expressions collect: [ :expression |
						    aViennaAbstractFormatter indentString: expression ]) ]
		   ifFalse: [
		   aViennaAbstractFormatter join: ', ' withAll: expressions ]) , ')'
]

{ #category : #private }
ViennaPreconditionExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :expression |
		expression freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaPreconditionExpressionNode >> isViennaPreconditionExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaPreconditionExpressionNode >> label [

	^ 'PreconditionExpression'
]
