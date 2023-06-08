Class {
	#name : #ViennaImportNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaImportNode class >> isAbstract [

	^ self = ViennaImportNode
]
