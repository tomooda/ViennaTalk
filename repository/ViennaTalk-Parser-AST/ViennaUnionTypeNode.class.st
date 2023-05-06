Class {
	#name : #ViennaUnionTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaUnionTypeNode >> label [

	^ 'UnionType'
]

{ #category : #'pretty printing' }
ViennaUnionTypeNode >> operatorPrecedence [

	^ 2
]
