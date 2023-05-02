Class {
	#name : #ViennaTotalFunctionTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaTotalFunctionTypeNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #accessing }
ViennaTotalFunctionTypeNode >> label [

	^ 'TotalFunctionType'
]
