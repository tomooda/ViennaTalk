Class {
	#name : #ViennaFunctionTypeNode,
	#superclass : #ViennaAbstractFunctionTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaFunctionTypeNode class >> isAbstract [

	^ self = ViennaFunctionTypeNode
]

{ #category : #'pretty printing' }
ViennaFunctionTypeNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #testing }
ViennaFunctionTypeNode >> isViennaFunctionTypeNode [

	^ true
]

{ #category : #'pretty printing' }
ViennaFunctionTypeNode >> operatorPrecedence [

	^ 1
]
