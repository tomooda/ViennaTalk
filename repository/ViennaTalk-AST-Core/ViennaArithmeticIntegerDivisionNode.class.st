Class {
	#name : 'ViennaArithmeticIntegerDivisionNode',
	#superclass : 'ViennaBinaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaArithmeticIntegerDivisionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'div'
]

{ #category : 'pretty printing' }
ViennaArithmeticIntegerDivisionNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : 'testing' }
ViennaArithmeticIntegerDivisionNode >> isViennaArithmeticIntegerDivisionNode [

	^ true
]

{ #category : 'accessing' }
ViennaArithmeticIntegerDivisionNode >> label [

	^ 'ArithmeticIntegerDivision'
]

{ #category : 'pretty printing' }
ViennaArithmeticIntegerDivisionNode >> operatorPrecedence [

	^ 32
]

{ #category : 'accessing' }
ViennaArithmeticIntegerDivisionNode >> paramType1 [

	^ ViennaType int
]

{ #category : 'accessing' }
ViennaArithmeticIntegerDivisionNode >> paramType2 [

	^ ViennaType int
]

{ #category : 'accessing' }
ViennaArithmeticIntegerDivisionNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ (aViennaType1 isNatType and: [ aViennaType2 isNatType ])
		  ifTrue: [ ViennaType nat ]
		  ifFalse: [ ViennaType int ]
]
