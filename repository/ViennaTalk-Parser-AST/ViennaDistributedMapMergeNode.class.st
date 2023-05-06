Class {
	#name : #ViennaDistributedMapMergeNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaDistributedMapMergeNode >> label [

	^ 'DistributedMapMerge'
]

{ #category : #'pretty printing' }
ViennaDistributedMapMergeNode >> operatorPrecedence [

	^ 36
]
