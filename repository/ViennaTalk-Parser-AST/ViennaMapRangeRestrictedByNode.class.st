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
