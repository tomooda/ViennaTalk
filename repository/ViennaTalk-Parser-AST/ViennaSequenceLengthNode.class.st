Class {
	#name : #ViennaSequenceLengthNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSequenceLengthNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'len'
]

{ #category : #testing }
ViennaSequenceLengthNode >> isViennaSequenceLengthNode [

	^ true
]

{ #category : #accessing }
ViennaSequenceLengthNode >> label [

	^ 'SequenceLength'
]

{ #category : #'pretty printing' }
ViennaSequenceLengthNode >> operatorPrecedence [

	^ 36
]
