Class {
	#name : #ViennaSet1TypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSet1TypeNode >> label [

	^ 'Set1Type'
]

{ #category : #'pretty printing' }
ViennaSet1TypeNode >> operatorPrecedence [

	^ 5
]
