Class {
	#name : #ViennaOperationTypeNode,
	#superclass : #ViennaAbstractFunctionTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #converting }
ViennaOperationTypeNode >> asMaximalViennaType [

	^ ViennaOperationType
		  withAll: (self argumentType isViennaUnitTypeNode
				   ifTrue: [ {  } ]
				   ifFalse: [
					   self argumentType isViennaProductTypeNode
						   ifTrue: [ self argumentType collect: #asMaximalViennaType ]
						   ifFalse: [ { self argumentType asMaximalViennaType } ] ])
		  with: self returnType asMaximalViennaType
]

{ #category : #'pretty printing' }
ViennaOperationTypeNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter format: self argumentType)
	  , aViennaAbstractFormatter space , aViennaAbstractFormatter oparrow
	  , aViennaAbstractFormatter space
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
