Class {
	#name : #ViennaLessThanOrEqualNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaLessThanOrEqualNode >> label [

	^ 'LessThanOrEqual'
]

{ #category : #'pretty printing' }
ViennaLessThanOrEqualNode >> operatorPrecedence [

	^ 21
]
