Class {
	#name : #ViennaSequenceLengthNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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

{ #category : #typechecking }
ViennaSequenceLengthNode >> paramType [

	^ ViennaType any seq
]

{ #category : #typechecking }
ViennaSequenceLengthNode >> returnTypeFor: aViennaType [

	^ aViennaType isSeq1Type
		  ifTrue: [ ViennaType nat1 ]
		  ifFalse: [ ViennaType nat ]
]
