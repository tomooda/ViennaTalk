Class {
	#name : #ViennaGreaterThanNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaGreaterThanNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '>'
]

{ #category : #accessing }
ViennaGreaterThanNode >> label [

	^ 'GreaterThan'
]

{ #category : #'pretty printing' }
ViennaGreaterThanNode >> operatorPrecedence [

	^ 21
]
