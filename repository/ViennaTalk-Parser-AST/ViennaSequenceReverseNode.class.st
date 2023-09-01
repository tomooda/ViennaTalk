Class {
	#name : #ViennaSequenceReverseNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSequenceReverseNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'reverse'
]

{ #category : #testing }
ViennaSequenceReverseNode >> isViennaSequenceReverseNode [

	^ true
]

{ #category : #accessing }
ViennaSequenceReverseNode >> label [

	^ 'SequenceReverse'
]

{ #category : #'pretty printing' }
ViennaSequenceReverseNode >> operatorPrecedence [

	^ 36
]
