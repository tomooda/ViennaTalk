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

	^ ViennaType real
]
