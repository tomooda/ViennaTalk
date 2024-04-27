Class {
	#name : #ViennaArithmeticModNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaArithmeticModNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'mod'
]

{ #category : #'pretty printing' }
ViennaArithmeticModNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaArithmeticModNode >> isViennaArithmeticModNode [

	^ true
]

{ #category : #accessing }
ViennaArithmeticModNode >> label [

	^ 'ArithmeticMod'
]

{ #category : #'pretty printing' }
ViennaArithmeticModNode >> operatorPrecedence [

	^ 32
]

{ #category : #accessing }
ViennaArithmeticModNode >> paramType1 [

	^ ViennaType int
]

{ #category : #accessing }
ViennaArithmeticModNode >> paramType2 [

	^ ViennaType int
]

{ #category : #accessing }
ViennaArithmeticModNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ aViennaType2 isNatType
		  ifTrue: [ ViennaType nat ]
		  ifFalse: [ ViennaType int ]
]
