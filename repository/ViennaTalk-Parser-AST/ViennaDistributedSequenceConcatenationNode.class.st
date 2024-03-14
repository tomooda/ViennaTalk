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

{ #category : #typechecking }
ViennaDistributedSequenceConcatenationNode >> maximalType: aViennaType [

	self expression maximalType: aViennaType seq.
	super maximalType: aViennaType
]

{ #category : #'pretty printing' }
ViennaDistributedSequenceConcatenationNode >> operatorPrecedence [

	^ 36
]

{ #category : #typechecking }
ViennaDistributedSequenceConcatenationNode >> paramType [

	^ ViennaType any seq seq
]

{ #category : #typechecking }
ViennaDistributedSequenceConcatenationNode >> returnTypeFor: aViennaType [

	^ aViennaType basetype
]
