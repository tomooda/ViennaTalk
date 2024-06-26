Class {
	#name : 'ViennaUnaryPlusNode',
	#superclass : 'ViennaUnaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaUnaryPlusNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '+'
]

{ #category : 'testing' }
ViennaUnaryPlusNode >> isViennaUnaryPlusNode [

	^ true
]

{ #category : 'accessing' }
ViennaUnaryPlusNode >> label [

	^ 'UnaryPlus'
]

{ #category : 'pretty printing' }
ViennaUnaryPlusNode >> operatorPrecedence [

	^ 36
]

{ #category : 'typechecking' }
ViennaUnaryPlusNode >> paramType [

	^ ViennaType real
]

{ #category : 'typechecking' }
ViennaUnaryPlusNode >> returnTypeFor: aViennaType [

	^ aViennaType
]
