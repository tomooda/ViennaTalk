Class {
	#name : #ViennaImportSignatureNode,
	#superclass : #ViennaImportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaImportSignatureNode class >> isAbstract [

	^ self = ViennaImportSignatureNode
]

{ #category : #private }
ViennaImportSignatureNode >> boundIdentifiersDo: aBlock [

	self do: [ :import | import boundIdentifiersDo: aBlock ]
]

{ #category : #enumerating }
ViennaImportSignatureNode >> importsDo: aBlock [

	self do: aBlock
]

{ #category : #testing }
ViennaImportSignatureNode >> isViennaImportSignatureNode [

	^ true
]

{ #category : #accessing }
ViennaImportSignatureNode >> moduleIdentifier [

	^ parent ifNotNil: #moduleIdentifier
]
