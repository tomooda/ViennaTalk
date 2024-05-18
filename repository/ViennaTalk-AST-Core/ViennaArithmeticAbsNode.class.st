Class {
	#name : 'ViennaArithmeticAbsNode',
	#superclass : 'ViennaUnaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaArithmeticAbsNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'abs'
]

{ #category : 'testing' }
ViennaArithmeticAbsNode >> isViennaArithmeticAbsNode [

	^ true
]

{ #category : 'accessing' }
ViennaArithmeticAbsNode >> label [

	^ 'ArithmeticAbs'
]

{ #category : 'pretty printing' }
ViennaArithmeticAbsNode >> operatorPrecedence [

	^ 36
]

{ #category : 'typechecking' }
ViennaArithmeticAbsNode >> paramType [

	^ ViennaType real
]

{ #category : 'typechecking' }
ViennaArithmeticAbsNode >> returnTypeFor: aViennaType [

	^ aViennaType isIntType
		  ifTrue: [ aViennaType & ViennaType nat ]
		  ifFalse: [ aViennaType ]
]
