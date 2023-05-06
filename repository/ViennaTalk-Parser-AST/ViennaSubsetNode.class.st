Class {
	#name : #ViennaSubsetNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSubsetNode >> label [

	^ 'Subset'
]

{ #category : #'pretty printing' }
ViennaSubsetNode >> operatorPrecedence [

	^ 21
]
