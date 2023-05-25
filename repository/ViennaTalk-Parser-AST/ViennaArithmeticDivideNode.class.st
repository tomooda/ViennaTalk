Class {
	#name : #ViennaArithmeticDivideNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaArithmeticDivideNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '/'
]

{ #category : #'pretty printing' }
ViennaArithmeticDivideNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #testing }
ViennaArithmeticDivideNode >> isViennaArithmeticDivideNode [

	^ true
]

{ #category : #accessing }
ViennaArithmeticDivideNode >> label [

	^ 'ArithmeticDivide'
]

{ #category : #'pretty printing' }
ViennaArithmeticDivideNode >> operatorPrecedence [

	^ 32
]
