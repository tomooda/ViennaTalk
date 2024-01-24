Class {
	#name : #ViennaPartialFunctionTypeNode,
	#superclass : #ViennaFunctionTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #converting }
ViennaPartialFunctionTypeNode >> asMaximalViennaType [

	^ self argumentType asMaximalViennaType
	  -> self returnType asMaximalViennaType
]

{ #category : #'pretty printing' }
ViennaPartialFunctionTypeNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter format: self argumentType) , ' '
	  , aViennaAbstractFormatter partialFunction , ' '
	  , (aViennaAbstractFormatter format: self returnType)
]

{ #category : #testing }
ViennaPartialFunctionTypeNode >> isViennaPartialFunctionTypeNode [

	^ true
]

{ #category : #accessing }
ViennaPartialFunctionTypeNode >> label [

	^ 'PartialFunctionType'
]
