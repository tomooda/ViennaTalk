Class {
	#name : #ViennaUnaryMinusNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaUnaryMinusNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '-'
]

{ #category : #testing }
ViennaUnaryMinusNode >> isViennaUnaryMinusNode [

	^ true
]

{ #category : #accessing }
ViennaUnaryMinusNode >> label [

	^ 'UnaryMinus'
]

{ #category : #typechecking }
ViennaUnaryMinusNode >> maximalType [

	| type |
	type := self expression typecheck.
	^ type isNatType
		  ifTrue: [ ViennaType int ]
		  ifFalse: [ type ]
]

{ #category : #'pretty printing' }
ViennaUnaryMinusNode >> operatorPrecedence [

	^ 36
]
