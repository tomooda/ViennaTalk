Class {
	#name : #ViennaOperationTypeNode,
	#superclass : #ViennaAbstractFunctionTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #converting }
ViennaOperationTypeNode >> asMaximalViennaType [

	^ self argumentType asMaximalViennaType
	  ==> self returnType asMaximalViennaType
]

{ #category : #'pretty printing' }
ViennaOperationTypeNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter format: self argumentType) , ' '
	  , aViennaAbstractFormatter oparrow , ' '
	  , (aViennaAbstractFormatter format: self returnType)
]

{ #category : #testing }
ViennaOperationTypeNode >> isViennaOperationTypeNode [

	^ true
]

{ #category : #accessing }
ViennaOperationTypeNode >> label [

	^ 'OperationType'
]
