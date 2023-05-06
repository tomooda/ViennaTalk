Class {
	#name : #ViennaPartialFunctionTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaPartialFunctionTypeNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #accessing }
ViennaPartialFunctionTypeNode >> label [

	^ 'PartialFunctionType'
]

{ #category : #'pretty printing' }
ViennaPartialFunctionTypeNode >> operatorPrecedence [

	^ 1
]
