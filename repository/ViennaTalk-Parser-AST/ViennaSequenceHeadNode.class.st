Class {
	#name : #ViennaSequenceHeadNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSequenceHeadNode >> label [

	^ 'SequenceHead'
]

{ #category : #'pretty printing' }
ViennaSequenceHeadNode >> operatorPrecedence [

	^ 36
]
