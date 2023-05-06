Class {
	#name : #ViennaSequenceLengthNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSequenceLengthNode >> label [

	^ 'SequenceLength'
]

{ #category : #'pretty printing' }
ViennaSequenceLengthNode >> operatorPrecedence [

	^ 36
]
