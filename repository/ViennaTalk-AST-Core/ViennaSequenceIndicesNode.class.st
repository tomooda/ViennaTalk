Class {
	#name : #ViennaSequenceIndicesNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaSequenceIndicesNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'inds'
]

{ #category : #testing }
ViennaSequenceIndicesNode >> isViennaSequenceIndicesNode [

	^ true
]

{ #category : #accessing }
ViennaSequenceIndicesNode >> label [

	^ 'SequenceIndices'
]

{ #category : #'pretty printing' }
ViennaSequenceIndicesNode >> operatorPrecedence [

	^ 36
]

{ #category : #typechecking }
ViennaSequenceIndicesNode >> paramType [

	^ ViennaType any seq
]

{ #category : #typechecking }
ViennaSequenceIndicesNode >> returnTypeFor: aViennaType [

	^ aViennaType isSeq1Type
		  ifTrue: [ ViennaType nat1 set1 ]
		  ifFalse: [ ViennaType nat1 set ]
]
