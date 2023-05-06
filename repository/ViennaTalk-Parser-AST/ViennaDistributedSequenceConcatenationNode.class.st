Class {
	#name : #ViennaDistributedSequenceConcatenationNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaDistributedSequenceConcatenationNode >> label [

	^ 'DistributedSequenceConcatenation'
]

{ #category : #'pretty printing' }
ViennaDistributedSequenceConcatenationNode >> operatorPrecedence [

	^ 36
]
