Class {
	#name : #ViennaSequenceReverseNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSequenceReverseNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'reverse'
]

{ #category : #testing }
ViennaSequenceReverseNode >> isViennaSequenceReverseNode [

	^ true
]

{ #category : #accessing }
ViennaSequenceReverseNode >> label [

	^ 'SequenceReverse'
]

{ #category : #typechecking }
ViennaSequenceReverseNode >> maximalType: aViennaType [

	self expression maximalType: aViennaType.
	super maximalType: aViennaType
]

{ #category : #'pretty printing' }
ViennaSequenceReverseNode >> operatorPrecedence [

	^ 36
]

{ #category : #typechecking }
ViennaSequenceReverseNode >> paramType [

	^ ViennaType any seq
]

{ #category : #typechecking }
ViennaSequenceReverseNode >> returnTypeFor: aViennaType [

	^ aViennaType
]
