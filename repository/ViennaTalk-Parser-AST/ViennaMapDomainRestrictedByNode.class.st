Class {
	#name : #ViennaMapDomainRestrictedByNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapDomainRestrictedByNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter domainRestrictedBy
]

{ #category : #'pretty printing' }
ViennaMapDomainRestrictedByNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #accessing }
ViennaMapDomainRestrictedByNode >> isViennaMapDomainRestrictedByNode [

	^ true
]

{ #category : #accessing }
ViennaMapDomainRestrictedByNode >> label [

	^ 'MapDomainRestrictedBy'
]

{ #category : #'pretty printing' }
ViennaMapDomainRestrictedByNode >> operatorPrecedence [

	^ 34
]

{ #category : #accessing }
ViennaMapDomainRestrictedByNode >> paramType1 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaMapDomainRestrictedByNode >> paramType2 [

	^ ViennaType any mapTo: ViennaType any
]
