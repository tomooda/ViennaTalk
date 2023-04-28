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

{ #category : #accessing }
ViennaPreconditionExpressionNode >> label [

	^ 'PreconditionExpression'
]
