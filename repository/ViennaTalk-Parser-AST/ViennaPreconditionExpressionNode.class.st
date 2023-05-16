Class {
	#name : #ViennaPreconditionExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaPreconditionExpressionNode class >> withAll: anArrayOfViennaExpressionNode [

	| pre |
	pre := self new: anArrayOfViennaExpressionNode size.
	1 to: anArrayOfViennaExpressionNode size do: [ :index |
		pre at: index put: (anArrayOfViennaExpressionNode at: index) ].
	^ pre
]

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

{ #category : #accessing }
ViennaPreconditionExpressionNode >> label [

	^ 'PreconditionExpression'
]
