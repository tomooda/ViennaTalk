Class {
	#name : #ViennaSequenceElementsNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSequenceElementsNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'elems'
]

{ #category : #testing }
ViennaSequenceElementsNode >> isViennaSequenceElementsNode [

	^ true
]

{ #category : #accessing }
ViennaSequenceElementsNode >> label [

	^ 'SequenceElements'
]

{ #category : #'pretty printing' }
ViennaSequenceElementsNode >> operatorPrecedence [

	^ 36
]
