Class {
	#name : #ViennaAndNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaAndNode >> label [

	^ 'And'
]

{ #category : #'pretty printing' }
ViennaAndNode >> operatorPrecedence [

	^ 14
]
