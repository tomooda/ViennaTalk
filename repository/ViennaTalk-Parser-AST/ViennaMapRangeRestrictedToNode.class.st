Class {
	#name : #ViennaMapRangeRestrictedToNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapRangeRestrictedToNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter rangeRestrictedTo
]

{ #category : #'pretty printing' }
ViennaMapRangeRestrictedToNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaMapRangeRestrictedToNode >> isViennaMapRangeRestrictedToNode [

	^ true
]

{ #category : #accessing }
ViennaMapRangeRestrictedToNode >> label [

	^ 'MapRangeRestrictedTo'
]

{ #category : #'pretty printing' }
ViennaMapRangeRestrictedToNode >> operatorPrecedence [

	^ 35
]

{ #category : #accessing }
ViennaMapRangeRestrictedToNode >> paramType1 [

	^ ViennaType any mapTo: ViennaType any
]

{ #category : #accessing }
ViennaMapRangeRestrictedToNode >> paramType2 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaMapRangeRestrictedToNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	| domainbasetype rangebasetype setbasetype |
	domainbasetype := aViennaType1 keytype.
	rangebasetype := aViennaType1 valuetype.
	setbasetype := aViennaType2 basetype.
	(setbasetype isCompatibleWith: rangebasetype) ifFalse: [
		^ ViennaTypeError signalOn: self ].
	^ aViennaType1
]
