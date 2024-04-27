Class {
	#name : #ViennaTotalFunctionTypeNode,
	#superclass : #ViennaFunctionTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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

	^ (aViennaAbstractFormatter format: self argumentType)
	  ++ aViennaAbstractFormatter space
	  ++ aViennaAbstractFormatter totalFunction
	  ++ aViennaAbstractFormatter space
	  ++ (aViennaAbstractFormatter format: self returnType)
]

{ #category : #testing }
ViennaTotalFunctionTypeNode >> isViennaTotalFunctionTypeNode [

	^ true
]

{ #category : #accessing }
ViennaTotalFunctionTypeNode >> label [

	^ 'TotalFunctionType'
]
