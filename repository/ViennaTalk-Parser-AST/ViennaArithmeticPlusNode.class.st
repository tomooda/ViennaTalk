Class {
	#name : #ViennaArithmeticPlusNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaArithmeticPlusNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '+'
]

{ #category : #'pretty printing' }
ViennaArithmeticPlusNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaArithmeticPlusNode >> isViennaArithmeticPlusNode [

	^ true
]

{ #category : #accessing }
ViennaArithmeticPlusNode >> label [

	^ 'ArithmeticPlus'
]

{ #category : #'pretty printing' }
ViennaArithmeticPlusNode >> operatorPrecedence [

	^ 31
]

{ #category : #accessing }
ViennaArithmeticPlusNode >> paramType1 [

	^ ViennaType real
]

{ #category : #accessing }
ViennaArithmeticPlusNode >> paramType2 [

	^ ViennaType real
]

{ #category : #accessing }
ViennaArithmeticPlusNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	(aViennaType1 isNat1Type and: [ aViennaType2 isNatType ]) ifTrue: [
		^ ViennaType nat1 ].
	(aViennaType1 isNatType and: [ aViennaType2 isNat1Type ]) ifTrue: [
		^ ViennaType nat1 ].
	(aViennaType1 isNatType and: [ aViennaType2 isNatType ]) ifTrue: [
		^ ViennaType nat ].
	^ (aViennaType1 isIntType and: [ aViennaType2 isIntType ])
		  ifTrue: [ ViennaType int ]
		  ifFalse: [ ViennaType real ]
]
