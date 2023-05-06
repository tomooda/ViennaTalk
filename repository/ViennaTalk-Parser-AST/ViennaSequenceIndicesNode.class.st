Class {
	#name : #ViennaSequenceIndicesNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSequenceIndicesNode >> label [

	^ 'SequenceIndices'
]

{ #category : #'pretty printing' }
ViennaSequenceIndicesNode >> operatorPrecedence [

	^ 36
]
