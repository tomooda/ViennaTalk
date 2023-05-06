Class {
	#name : #ViennaEqualNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaEqualNode >> label [

	^ 'Equal'
]

{ #category : #'pretty printing' }
ViennaEqualNode >> operatorPrecedence [

	^ 21
]
