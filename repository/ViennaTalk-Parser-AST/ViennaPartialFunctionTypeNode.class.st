Class {
	#name : #ViennaPartialFunctionTypeNode,
	#superclass : #ViennaFunctionTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #converting }
ViennaPartialFunctionTypeNode >> asMaximalViennaType [

	^ ViennaPartialFunctionType
		  withAll: (self argumentType isViennaUnitTypeNode
				   ifTrue: [ {  } ]
				   ifFalse: [
					   self argumentType isViennaProductTypeNode
						   ifTrue: [ self argumentType collect: #asMaximalViennaType ]
						   ifFalse: [ { self argumentType asMaximalViennaType } ] ])
		  with: self returnType asMaximalViennaType
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
