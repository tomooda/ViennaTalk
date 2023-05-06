Class {
	#name : #ViennaDistributedSetIntersectionNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaDistributedSetIntersectionNode >> label [

	^ 'DistributedSetIntersection'
]

{ #category : #'pretty printing' }
ViennaDistributedSetIntersectionNode >> operatorPrecedence [

	^ 36
]
