Class {
	#name : #ViennaProductTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaProductTypeNode >> label [

	^ 'ProductType'
]

{ #category : #'pretty printing' }
ViennaProductTypeNode >> operatorPrecedence [

	^ 3
]
