Class {
	#name : #ViennaMapTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaMapTypeNode >> label [

	^ 'MapType'
]

{ #category : #'pretty printing' }
ViennaMapTypeNode >> operatorPrecedence [

	^ 4
]
