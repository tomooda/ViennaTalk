Class {
	#name : #ViennaSequenceTailNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSequenceTailNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'tl'
]

{ #category : #accessing }
ViennaSequenceTailNode >> label [

	^ 'SequenceTail'
]

{ #category : #'pretty printing' }
ViennaSequenceTailNode >> operatorPrecedence [

	^ 36
]
