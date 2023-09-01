Class {
	#name : #ViennaExportSignatureNode,
	#superclass : #ViennaExportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaExportSignatureNode class >> isAbstract [

	^ self = ViennaExportSignatureNode
]

{ #category : #private }
ViennaExportSignatureNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #enumerating }
ViennaExportSignatureNode >> exportedIdentifiersDo: aBlock [

	^ self do: [ :export | export exportedIdentifiersDo: aBlock ]
]

{ #category : #removing }
ViennaExportSignatureNode >> removeIdentifier: aString [

	(self exportsIdentifier: aString) ifTrue: [
		self do: [ :export | export removeIdentifier: aString ].
		self ifEmpty: [ parent ifNotNil: [ parent remove: self ] ] ]
]
