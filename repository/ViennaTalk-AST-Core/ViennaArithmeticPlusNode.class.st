Class {
	#name : 'ViennaArithmeticPlusNode',
	#superclass : 'ViennaBinaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaArithmeticPlusNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '+'
]

{ #category : 'pretty printing' }
ViennaArithmeticPlusNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : 'accessing' }
ViennaArithmeticPlusNode >> isViennaArithmeticPlusNode [

	^ true
]

{ #category : 'accessing' }
ViennaArithmeticPlusNode >> label [

	^ 'ArithmeticPlus'
]

{ #category : 'pretty printing' }
ViennaArithmeticPlusNode >> operatorPrecedence [

	^ 31
]

{ #category : 'accessing' }
ViennaArithmeticPlusNode >> paramType1 [

	^ ViennaType real
]

{ #category : 'accessing' }
ViennaArithmeticPlusNode >> paramType2 [

	^ ViennaType real
]

{ #category : 'accessing' }
ViennaArithmeticPlusNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	(aViennaType1 isNatType and: [ aViennaType2 isNatType ]) ifTrue: [
		^ (aViennaType1 isNat1Type or: [ aViennaType2 isNat1Type ])
			  ifTrue: [ ViennaType nat1 ]
			  ifFalse: [ ViennaType nat ] ].
	(aViennaType1 isIntType and: [ aViennaType2 isIntType ]) ifTrue: [
		^ ViennaType int ].
	^ ViennaType real
]
