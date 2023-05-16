Class {
	#name : #ViennaSubsetNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSubsetNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter subset
]

{ #category : #accessing }
ViennaSubsetNode >> label [

	^ 'Subset'
]

{ #category : #'pretty printing' }
ViennaSubsetNode >> operatorPrecedence [

	^ 21
]
