Class {
	#name : #ViennaPartialFunctionTypeNode,
	#superclass : #ViennaAbstractFunctionTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaPartialFunctionTypeNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter format: self argumentType) , ' '
	  , aViennaAbstractFormatter partialFunction , ' '
	  , (aViennaAbstractFormatter format: self returnType)
]

{ #category : #'pretty printing' }
ViennaPartialFunctionTypeNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #testing }
ViennaPartialFunctionTypeNode >> isViennaPartialFunctionTypeNode [

	^ true
]

{ #category : #accessing }
ViennaPartialFunctionTypeNode >> label [

	^ 'PartialFunctionType'
]

{ #category : #'pretty printing' }
ViennaPartialFunctionTypeNode >> operatorPrecedence [

	^ 1
]
