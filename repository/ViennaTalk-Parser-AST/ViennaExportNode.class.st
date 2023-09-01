Class {
	#name : #ViennaExportNode,
	#superclass : #ViennaExportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaExportNode class >> isAbstract [

	^ self = ViennaExportNode
]

{ #category : #private }
ViennaExportNode >> boundIdentifiersDo: aBlock [

	
]
