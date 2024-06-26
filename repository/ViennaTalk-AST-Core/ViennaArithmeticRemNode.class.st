Class {
	#name : 'ViennaArithmeticRemNode',
	#superclass : 'ViennaBinaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaArithmeticRemNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'rem'
]

{ #category : 'pretty printing' }
ViennaArithmeticRemNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : 'accessing' }
ViennaArithmeticRemNode >> isViennaArithmeticRemNode [

	^ true
]

{ #category : 'accessing' }
ViennaArithmeticRemNode >> label [

	^ 'ArithmeticRem'
]

{ #category : 'pretty printing' }
ViennaArithmeticRemNode >> operatorPrecedence [

	^ 32
]

{ #category : 'accessing' }
ViennaArithmeticRemNode >> paramType1 [

	^ ViennaType real
]

{ #category : 'accessing' }
ViennaArithmeticRemNode >> paramType2 [

	^ ViennaType real
]

{ #category : 'accessing' }
ViennaArithmeticRemNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ ViennaType real
]
