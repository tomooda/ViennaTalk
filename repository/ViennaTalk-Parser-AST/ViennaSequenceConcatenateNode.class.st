Class {
	#name : #ViennaSequenceConcatenateNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSequenceConcatenateNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter concat
]

{ #category : #'pretty printing' }
ViennaSequenceConcatenateNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #testing }
ViennaSequenceConcatenateNode >> isViennaSequenceConcatenateNode [

	^ true
]

{ #category : #accessing }
ViennaSequenceConcatenateNode >> label [

	^ 'SequenceConcatenate'
]

{ #category : #'pretty printing' }
ViennaSequenceConcatenateNode >> operatorPrecedence [

	^ 31
]

{ #category : #accessing }
ViennaSequenceConcatenateNode >> paramType1 [

	^ ViennaType any seq
]

{ #category : #accessing }
ViennaSequenceConcatenateNode >> paramType2 [

	^ ViennaType any seq
]

{ #category : #accessing }
ViennaSequenceConcatenateNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	| basetype |
	basetype := aViennaType1 basetype >= aViennaType2 basetype
		            ifTrue: [ aViennaType1 basetype ]
		            ifFalse: [
			            aViennaType2 >= aViennaType1
				            ifTrue: [ aViennaType2 basetype ]
				            ifFalse: [
				            aViennaType1 basetype | aViennaType2 basetype ] ].
	^ (aViennaType1 isSeq1Type or: [ aViennaType2 isSeq1Type ])
		  ifTrue: [ basetype seq1 ]
		  ifFalse: [ basetype seq ]
]
