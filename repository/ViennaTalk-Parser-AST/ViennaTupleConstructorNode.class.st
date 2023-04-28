Class {
	#name : #ViennaTupleConstructorNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTupleConstructorNode class >> withAll: anArrayOfViennaExpressionNode [

	| tuple |
	tuple := self new: anArrayOfViennaExpressionNode size.
	1 to: anArrayOfViennaExpressionNode size do: [ :index |
		tuple at: index put: (anArrayOfViennaExpressionNode at: index) ].
	^ tuple
]

{ #category : #accessing }
ViennaTupleConstructorNode >> label [

	^ 'TupleConstructor'
]
