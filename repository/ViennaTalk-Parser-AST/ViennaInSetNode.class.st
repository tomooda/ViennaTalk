Class {
	#name : #ViennaInSetNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaInSetNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter inset
]

{ #category : #accessing }
ViennaInSetNode >> isViennaInSetNode [

	^ true
]

{ #category : #accessing }
ViennaInSetNode >> label [

	^ 'InSet'
]

{ #category : #'pretty printing' }
ViennaInSetNode >> operatorPrecedence [

	^ 21
]
