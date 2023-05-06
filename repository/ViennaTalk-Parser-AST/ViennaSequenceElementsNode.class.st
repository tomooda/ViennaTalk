Class {
	#name : #ViennaSequenceElementsNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSequenceElementsNode >> label [

	^ 'SequenceElements'
]

{ #category : #'pretty printing' }
ViennaSequenceElementsNode >> operatorPrecedence [

	^ 36
]
