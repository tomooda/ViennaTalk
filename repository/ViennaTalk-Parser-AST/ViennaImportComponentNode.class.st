Class {
	#name : #ViennaImportComponentNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaImportComponentNode class >> isAbstract [

	^ self = ViennaImportComponentNode
]
