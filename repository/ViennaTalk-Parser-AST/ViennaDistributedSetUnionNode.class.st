Class {
	#name : #ViennaDistributedSetUnionNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaDistributedSetUnionNode >> label [

	^ 'DistributedSetUnion'
]

{ #category : #'pretty printing' }
ViennaDistributedSetUnionNode >> operatorPrecedence [

	^ 36
]
