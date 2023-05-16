Class {
	#name : #ViennaTimeExpressionNode,
	#superclass : #ViennaReservedNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaTimeExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ 'time'
]

{ #category : #accessing }
ViennaTimeExpressionNode >> label [

	^ 'TimeExpression'
]
