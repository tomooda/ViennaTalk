Class {
	#name : #ViennaArithmeticMinusNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaArithmeticMinusNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '-'
]

{ #category : #'pretty printing' }
ViennaArithmeticMinusNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaArithmeticMinusNode >> isViennaArithmeticMinusNode [

	^ true
]

{ #category : #accessing }
ViennaArithmeticMinusNode >> label [

	^ 'ArithmeticMinus'
]

{ #category : #'pretty printing' }
ViennaArithmeticMinusNode >> operatorPrecedence [

	^ 31
]

{ #category : #accessing }
ViennaArithmeticMinusNode >> paramType1 [

	^ ViennaType real
]

{ #category : #accessing }
ViennaArithmeticMinusNode >> paramType2 [

	^ ViennaType real
]

{ #category : #accessing }
ViennaArithmeticMinusNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ (aViennaType1 isIntType and: [ aViennaType2 isIntType ])
		  ifTrue: [ ViennaType int ]
		  ifFalse: [ ViennaType real ]
]
