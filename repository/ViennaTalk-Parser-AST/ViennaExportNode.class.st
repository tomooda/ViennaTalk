Class {
	#name : #ViennaExportNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaExportNode class >> isAbstract [

	^ self = ViennaExportNode
]

{ #category : #testing }
ViennaExportNode >> exportsName: aViennaNameNode [

	^ self subclassResponsibility
]

{ #category : #enumerating }
ViennaExportNode >> namesDo: aBlock [

	^ self subclassResponsibility
]
