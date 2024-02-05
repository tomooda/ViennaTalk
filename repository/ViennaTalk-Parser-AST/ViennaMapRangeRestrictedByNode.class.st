Class {
	#name : #ViennaMapRangeRestrictedByNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapRangeRestrictedByNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter rangeRestrictedBy
]

{ #category : #'pretty printing' }
ViennaMapRangeRestrictedByNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaMapRangeRestrictedByNode >> isViennaMapRangeRestrictedByNode [

	^ true
]

{ #category : #accessing }
ViennaMapRangeRestrictedByNode >> label [

	^ 'MapRangeRestrictedBy'
]

{ #category : #'pretty printing' }
ViennaMapRangeRestrictedByNode >> operatorPrecedence [

	^ 35
]

{ #category : #accessing }
ViennaMapRangeRestrictedByNode >> paramType1 [

	^ ViennaType any mapTo: ViennaType any
]

{ #category : #accessing }
ViennaMapRangeRestrictedByNode >> paramType2 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaMapRangeRestrictedByNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	| domainbasetype rangebasetype setbasetype |
	domainbasetype := aViennaType1 keytype.
	rangebasetype := aViennaType1 valuetype.
	setbasetype := aViennaType2 basetype.
	(setbasetype isCompatibleWith: rangebasetype) ifFalse: [
		^ ViennaTypeError signalOn: self ].
	^ aViennaType1
]
