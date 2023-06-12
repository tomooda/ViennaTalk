Class {
	#name : #ViennaImportSignatureNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaImportSignatureNode class >> isAbstract [

	^ self = ViennaImportSignatureNode
]

{ #category : #testing }
ViennaImportSignatureNode >> isViennaImportSignatureNode [

	^ true
]
