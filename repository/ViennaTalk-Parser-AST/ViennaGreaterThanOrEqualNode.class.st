Class {
	#name : #ViennaGreaterThanOrEqualNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaGreaterThanOrEqualNode >> label [

	^ 'GreaterThanOrEqual'
]

{ #category : #'pretty printing' }
ViennaGreaterThanOrEqualNode >> operatorPrecedence [

	^ 21
]
