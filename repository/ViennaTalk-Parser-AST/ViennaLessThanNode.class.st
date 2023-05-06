Class {
	#name : #ViennaLessThanNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaLessThanNode >> label [

	^ 'LessThan'
]

{ #category : #'pretty printing' }
ViennaLessThanNode >> operatorPrecedence [

	^ 21
]
