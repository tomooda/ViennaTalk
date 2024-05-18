Class {
	#name : 'ViennaDummyNode',
	#superclass : 'ViennaNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'private' }
ViennaDummyNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'pretty printing' }
ViennaDummyNode >> formatWith: aViennaAbstractFormatter [

	^ '--dummy--'
]

{ #category : 'private' }
ViennaDummyNode >> freeIdentifiersExcept: aSet do: aBlock [

	
]

{ #category : 'accessing' }
ViennaDummyNode >> label [

	^ '--DUMMY--'
]

{ #category : 'typechecking' }
ViennaDummyNode >> maximalType [

	^ ViennaTypeError
		  on: self
		  signal: 'Dummy node can not be typechecked'
]
