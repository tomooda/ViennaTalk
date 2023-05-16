Class {
	#name : #ViennaNotEqualNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaNotEqualNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter notEqual
]

{ #category : #accessing }
ViennaNotEqualNode >> label [

	^ 'NotEqual'
]

{ #category : #'pretty printing' }
ViennaNotEqualNode >> operatorPrecedence [

	^ 21
]
