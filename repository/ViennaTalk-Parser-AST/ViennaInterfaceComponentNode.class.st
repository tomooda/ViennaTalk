Class {
	#name : #ViennaInterfaceComponentNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaInterfaceComponentNode class >> isAbstract [

	^ self = ViennaInterfaceComponentNode
]

{ #category : #private }
ViennaInterfaceComponentNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : #testing }
ViennaInterfaceComponentNode >> isViennaInterfaceComponentNode [

	^ true
]
