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

{ #category : #private }
ViennaImportSignatureNode >> boundIdentifiersInto: aSet [

	self do: [ :import | import boundIdentifiersInto: aSet ]
]

{ #category : #testing }
ViennaImportSignatureNode >> isViennaImportSignatureNode [

	^ true
]
