Class {
	#name : #ViennaSequenceHeadNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSequenceHeadNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'hd'
]

{ #category : #accessing }
ViennaSequenceHeadNode >> isViennaSequenceHeadNode [

	^ true
]

{ #category : #accessing }
ViennaSequenceHeadNode >> label [

	^ 'SequenceHead'
]

{ #category : #'pretty printing' }
ViennaSequenceHeadNode >> operatorPrecedence [

	^ 36
]
