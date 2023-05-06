Class {
	#name : #ViennaSetIntersectionNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSetIntersectionNode >> label [

	^ 'SetIntersection'
]

{ #category : #'pretty printing' }
ViennaSetIntersectionNode >> operatorPrecedence [

	^ 32
]
