Class {
	#name : #ViennaMapDomainRestrictedByNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapDomainRestrictedByNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #accessing }
ViennaMapDomainRestrictedByNode >> label [

	^ 'MapDomainRestrictedBy'
]
