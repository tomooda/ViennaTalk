Class {
	#name : #ViennaInSetNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaInSetNode >> label [

	^ 'InSet'
]

{ #category : #'pretty printing' }
ViennaInSetNode >> operatorPrecedence [

	^ 21
]
