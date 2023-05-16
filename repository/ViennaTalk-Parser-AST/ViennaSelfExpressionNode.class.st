Class {
	#name : #ViennaSelfExpressionNode,
	#superclass : #ViennaReservedNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSelfExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ 'self'
]

{ #category : #accessing }
ViennaSelfExpressionNode >> label [

	^ 'SelfExpression'
]
