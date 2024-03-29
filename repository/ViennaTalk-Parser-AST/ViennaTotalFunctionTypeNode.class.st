Class {
	#name : #ViennaTotalFunctionTypeNode,
	#superclass : #ViennaFunctionTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #converting }
ViennaTotalFunctionTypeNode >> asMaximalViennaType [

	^ ViennaTotalFunctionType
		  withAll: (self argumentType isViennaUnitTypeNode
				   ifTrue: [ {  } ]
				   ifFalse: [
					   self argumentType isViennaProductTypeNode
						   ifTrue: [ self argumentType collect: #asMaximalViennaType ]
						   ifFalse: [ { self argumentType asMaximalViennaType } ] ])
		  with: self returnType asMaximalViennaType
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
