Class {
	#name : #ViennaSequenceElementsNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaSequenceElementsNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'elems'
]

{ #category : #testing }
ViennaSequenceElementsNode >> isViennaSequenceElementsNode [

	^ true
]

{ #category : #accessing }
ViennaSequenceElementsNode >> label [

	^ 'SequenceElements'
]

{ #category : #typechecking }
ViennaSequenceElementsNode >> maximalType: aViennaType [

	| basetype isSet1Type |
	aViennaType isAnyType
		ifTrue: [
			isSet1Type := false.
			basetype := ViennaType any ]
		ifFalse: [
			basetype := ViennaType unit.
			isSet1Type := true.
			aViennaType possibleTypesSuchThat: #isSetType do: [ :setType |
				basetype := basetype + setType basetype.
				setType isSeq1Type ifFalse: [ isSet1Type := false ] ] ].
	self expression maximalType: (isSet1Type
			 ifTrue: [ basetype seq1 ]
			 ifFalse: [ basetype seq ]).
	super maximalType: aViennaType
]

{ #category : #'pretty printing' }
ViennaSequenceElementsNode >> operatorPrecedence [

	^ 36
]

{ #category : #typechecking }
ViennaSequenceElementsNode >> paramType [

	^ ViennaType any seq
]

{ #category : #typechecking }
ViennaSequenceElementsNode >> returnTypeFor: aViennaType [

	| basetype isSeq1Type |
	aViennaType isAnyType
		ifTrue: [
			isSeq1Type := false.
			basetype := ViennaType any ]
		ifFalse: [
			basetype := ViennaType unit.
			isSeq1Type := true.
			aViennaType possibleTypesSuchThat: #isSeqType do: [ :seqType |
				basetype := basetype + seqType basetype.
				seqType isSeq1Type ifFalse: [ isSeq1Type := false ] ] ].
	^ isSeq1Type
		  ifTrue: [ basetype set1 ]
		  ifFalse: [ basetype set ]
]
