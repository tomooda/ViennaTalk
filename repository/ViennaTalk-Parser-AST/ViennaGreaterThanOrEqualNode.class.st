Class {
	#name : #ViennaGreaterThanOrEqualNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaGreaterThanOrEqualNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ '>='
]

{ #category : #accessing }
ViennaGreaterThanOrEqualNode >> label [

	^ 'GreaterThanOrEqual'
]

{ #category : #'pretty printing' }
ViennaGreaterThanOrEqualNode >> operatorPrecedence [

	^ 21
]
