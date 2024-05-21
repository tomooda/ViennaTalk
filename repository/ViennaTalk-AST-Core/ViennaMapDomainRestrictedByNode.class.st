Class {
	#name : 'ViennaMapDomainRestrictedByNode',
	#superclass : 'ViennaBinaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaMapDomainRestrictedByNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter domainRestrictedBy
]

{ #category : 'pretty printing' }
ViennaMapDomainRestrictedByNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : 'accessing' }
ViennaMapDomainRestrictedByNode >> isViennaMapDomainRestrictedByNode [

	^ true
]

{ #category : 'accessing' }
ViennaMapDomainRestrictedByNode >> label [

	^ 'MapDomainRestrictedBy'
]

{ #category : 'pretty printing' }
ViennaMapDomainRestrictedByNode >> operatorPrecedence [

	^ 34
]

{ #category : 'accessing' }
ViennaMapDomainRestrictedByNode >> paramType1 [

	^ ViennaType any set
]

{ #category : 'accessing' }
ViennaMapDomainRestrictedByNode >> paramType2 [

	^ ViennaType any mapTo: ViennaType any
]

{ #category : 'accessing' }
ViennaMapDomainRestrictedByNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	| setbasetype domainbasetype rangebasetype |
	setbasetype := aViennaType1 basetype.
	domainbasetype := aViennaType2 keytype.
	rangebasetype := aViennaType2 valuetype.
	(setbasetype isCompatibleWith: domainbasetype) ifFalse: [
		^ ViennaTypeError signalOn: self ].
	^ aViennaType2
]
