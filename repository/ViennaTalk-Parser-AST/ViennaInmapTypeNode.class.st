Class {
	#name : #ViennaInmapTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaInmapTypeNode >> label [

	^ 'InmapType'
]

{ #category : #'pretty printing' }
ViennaInmapTypeNode >> operatorPrecedence [

	^ 4
]
