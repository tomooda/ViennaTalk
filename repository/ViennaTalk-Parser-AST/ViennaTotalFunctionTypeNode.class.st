Class {
	#name : #ViennaTotalFunctionTypeNode,
	#superclass : #ViennaFunctionTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #converting }
ViennaTotalFunctionTypeNode >> asMaximalViennaType [

	^ self argumentType asMaximalViennaType
	  +> self returnType asMaximalViennaType
]

{ #category : #'pretty printing' }
ViennaTotalFunctionTypeNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter format: self argumentType) , ' '
	  , aViennaAbstractFormatter totalFunction , ' '
	  , (aViennaAbstractFormatter format: self returnType)
]

{ #category : #testing }
ViennaTotalFunctionTypeNode >> isViennaTotalFunctionTypeNode [

	^ true
]

{ #category : #accessing }
ViennaTotalFunctionTypeNode >> label [

	^ 'TotalFunctionType'
]
