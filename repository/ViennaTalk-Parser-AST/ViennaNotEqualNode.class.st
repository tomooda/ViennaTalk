Class {
	#name : #ViennaNotEqualNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaNotEqualNode >> label [

	^ 'NotEqual'
]

{ #category : #'pretty printing' }
ViennaNotEqualNode >> operatorPrecedence [

	^ 21
]
