Class {
	#name : #ViennaOrNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaOrNode >> label [

	^ 'Or'
]

{ #category : #'pretty printing' }
ViennaOrNode >> operatorPrecedence [

	^ 13
]
