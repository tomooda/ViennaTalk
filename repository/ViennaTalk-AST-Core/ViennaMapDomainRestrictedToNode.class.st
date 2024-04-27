Class {
	#name : #ViennaMapDomainRestrictedToNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaMapDomainRestrictedToNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter domainRestrictedTo
]

{ #category : #'pretty printing' }
ViennaMapDomainRestrictedToNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #accessing }
ViennaMapDomainRestrictedToNode >> isViennaMapDomainRestrictedToNode [

	^ true
]

{ #category : #accessing }
ViennaMapDomainRestrictedToNode >> label [

	^ 'MapDomainRestrictedTo'
]

{ #category : #'pretty printing' }
ViennaMapDomainRestrictedToNode >> operatorPrecedence [

	^ 34
]

{ #category : #accessing }
ViennaMapDomainRestrictedToNode >> paramType1 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaMapDomainRestrictedToNode >> paramType2 [

	^ ViennaType any mapTo: ViennaType any
]

{ #category : #accessing }
ViennaMapDomainRestrictedToNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	| setbasetype domainbasetype rangebasetype |
	setbasetype := aViennaType1 basetype.
	domainbasetype := aViennaType2 keytype.
	rangebasetype := aViennaType2 valuetype.
	(setbasetype isCompatibleWith: domainbasetype) ifFalse: [
		^ ViennaTypeError signalOn: self ].
	^ aViennaType2
]
