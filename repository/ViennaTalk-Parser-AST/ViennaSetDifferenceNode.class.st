Class {
	#name : #ViennaSetDifferenceNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSetDifferenceNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter setDifference
]

{ #category : #'pretty printing' }
ViennaSetDifferenceNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaSetDifferenceNode >> isViennaSetDifferenceNode [

	^ true
]

{ #category : #accessing }
ViennaSetDifferenceNode >> label [

	^ 'SetDifference'
]

{ #category : #'pretty printing' }
ViennaSetDifferenceNode >> operatorPrecedence [

	^ 31
]

{ #category : #accessing }
ViennaSetDifferenceNode >> paramType1 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaSetDifferenceNode >> paramType2 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaSetDifferenceNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ (aViennaType1 basetype isCompatibleWith: aViennaType2 basetype)
		  ifTrue: [ aViennaType1 ]
		  ifFalse: [ ViennaTypeError signalOn: self ]
]
