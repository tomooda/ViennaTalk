Class {
	#name : #ViennaSequenceConcatenateNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSequenceConcatenateNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaSequenceConcatenateNode >> label [

	^ 'SequenceConcatenate'
]

{ #category : #'pretty printing' }
ViennaSequenceConcatenateNode >> operatorPrecedence [

	^ 31
]
