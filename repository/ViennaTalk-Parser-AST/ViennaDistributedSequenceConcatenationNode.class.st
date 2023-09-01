Class {
	#name : #ViennaDistributedSequenceConcatenationNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaDistributedSequenceConcatenationNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'conc'
]

{ #category : #testing }
ViennaDistributedSequenceConcatenationNode >> isViennaDistributedSequenceConcatenationNode [

	^ true
]

{ #category : #accessing }
ViennaDistributedSequenceConcatenationNode >> label [

	^ 'DistributedSequenceConcatenation'
]

{ #category : #'pretty printing' }
ViennaDistributedSequenceConcatenationNode >> operatorPrecedence [

	^ 36
]
