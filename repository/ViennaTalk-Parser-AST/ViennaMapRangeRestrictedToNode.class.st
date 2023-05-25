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
