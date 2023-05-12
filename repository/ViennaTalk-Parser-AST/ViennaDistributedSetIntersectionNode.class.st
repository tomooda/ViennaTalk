Class {
	#name : #ViennaDistributedSetIntersectionNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaDistributedSetIntersectionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter dinter
]

{ #category : #accessing }
ViennaDistributedSetIntersectionNode >> label [

	^ 'DistributedSetIntersection'
]

{ #category : #'pretty printing' }
ViennaDistributedSetIntersectionNode >> operatorPrecedence [

	^ 36
]
