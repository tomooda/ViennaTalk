Class {
	#name : #ViennaDistributedSetUnionNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaDistributedSetUnionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter dunion
]

{ #category : #accessing }
ViennaDistributedSetUnionNode >> label [

	^ 'DistributedSetUnion'
]

{ #category : #'pretty printing' }
ViennaDistributedSetUnionNode >> operatorPrecedence [

	^ 36
]
