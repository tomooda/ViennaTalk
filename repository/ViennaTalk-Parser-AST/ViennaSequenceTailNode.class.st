Class {
	#name : #ViennaSequenceTailNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSequenceTailNode >> label [

	^ 'SequenceTail'
]

{ #category : #'pretty printing' }
ViennaSequenceTailNode >> operatorPrecedence [

	^ 36
]
