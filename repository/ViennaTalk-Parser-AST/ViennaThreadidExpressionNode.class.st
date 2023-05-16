Class {
	#name : #ViennaThreadidExpressionNode,
	#superclass : #ViennaReservedNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaThreadidExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ 'threadid'
]

{ #category : #accessing }
ViennaThreadidExpressionNode >> label [

	^ 'ThreadidExpression'
]
