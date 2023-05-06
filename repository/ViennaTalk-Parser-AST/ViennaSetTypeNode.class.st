Class {
	#name : #ViennaSetTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSetTypeNode >> label [

	^ 'SetType'
]

{ #category : #'pretty printing' }
ViennaSetTypeNode >> operatorPrecedence [

	^ 5
]
