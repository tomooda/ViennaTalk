Class {
	#name : #ViennaHistoryExpressionNode,
	#superclass : #ViennaReservedNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaHistoryExpressionNode class >> withAll: anArrayOfViennaNameNode [

	| historyExpression |
	historyExpression := self new: anArrayOfViennaNameNode size.
	1 to: anArrayOfViennaNameNode size do: [ :index |
		historyExpression at: index put: (anArrayOfViennaNameNode at: index) ].
	^ historyExpression
]
