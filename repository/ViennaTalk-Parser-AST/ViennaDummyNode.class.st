Class {
	#name : #ViennaDummyNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaDummyNode >> formatWith: aViennaAbstractFormatter [

	^ '--dummy--'
]
