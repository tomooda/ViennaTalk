Class {
	#name : #ViennaImportComponentNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #testing }
ViennaImportComponentNode class >> isAbstract [

	^ self = ViennaImportComponentNode
]
