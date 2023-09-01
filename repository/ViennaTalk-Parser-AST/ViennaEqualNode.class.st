Class {
	#name : #ViennaEqualNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaEqualNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '='
]

{ #category : #accessing }
ViennaEqualNode >> isViennaEqualNode [

	^ true
]

{ #category : #accessing }
ViennaEqualNode >> label [

	^ 'Equal'
]

{ #category : #'pretty printing' }
ViennaEqualNode >> operatorPrecedence [

	^ 21
]
