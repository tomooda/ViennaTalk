Class {
	#name : #ViennaDummyNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaDummyNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaDummyNode >> formatWith: aViennaAbstractFormatter [

	^ '--dummy--'
]

{ #category : #private }
ViennaDummyNode >> freeIdentifiersExcept: aSet do: aBlock [

	
]

{ #category : #accessing }
ViennaDummyNode >> label [

	^ '--DUMMY--'
]
