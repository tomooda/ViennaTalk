Class {
	#name : 'ViennaUnaryMinusNode',
	#superclass : 'ViennaUnaryOperatorExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaUnaryMinusNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '-'
]

{ #category : 'testing' }
ViennaUnaryMinusNode >> isViennaUnaryMinusNode [

	^ true
]

{ #category : 'accessing' }
ViennaUnaryMinusNode >> label [

	^ 'UnaryMinus'
]

{ #category : 'pretty printing' }
ViennaUnaryMinusNode >> operatorPrecedence [

	^ 36
]

{ #category : 'typechecking' }
ViennaUnaryMinusNode >> paramType [

	^ ViennaType real
]

{ #category : 'typechecking' }
ViennaUnaryMinusNode >> returnTypeFor: aViennaType [

	^ aViennaType isIntType
		  ifTrue: [ ViennaType int ]
		  ifFalse: [ aViennaType ]
]
