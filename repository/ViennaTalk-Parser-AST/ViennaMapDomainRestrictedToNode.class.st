Class {
	#name : #ViennaMapDomainRestrictedToNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapDomainRestrictedToNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #accessing }
ViennaMapDomainRestrictedToNode >> label [

	^ 'MapDomainRestrictedTo'
]

{ #category : #'pretty printing' }
ViennaMapDomainRestrictedToNode >> operatorPrecedence [

	^ 34
]
