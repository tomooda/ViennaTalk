Class {
	#name : #ViennaTotalFunctionTypeNode,
	#superclass : #ViennaAbstractFunctionTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaTotalFunctionTypeNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter format: self argumentType) , ' '
	  , aViennaAbstractFormatter totalFunction , ' '
	  , (aViennaAbstractFormatter format: self returnType)
]

{ #category : #'pretty printing' }
ViennaTotalFunctionTypeNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock2 value
]

{ #category : #testing }
ViennaTotalFunctionTypeNode >> isViennaTotalFunctionTypeNode [

	^ true
]

{ #category : #accessing }
ViennaTotalFunctionTypeNode >> label [

	^ 'TotalFunctionType'
]

{ #category : #'pretty printing' }
ViennaTotalFunctionTypeNode >> operatorPrecedence [

	^ 1
]
