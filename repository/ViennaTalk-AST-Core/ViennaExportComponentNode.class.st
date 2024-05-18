Class {
	#name : 'ViennaExportComponentNode',
	#superclass : 'ViennaInterfaceComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaExportComponentNode class >> isAbstract [

	^ self = ViennaExportComponentNode
]

{ #category : 'accessing' }
ViennaExportComponentNode >> exportedIdentifiers [

	| identifiers |
	identifiers := Set new.
	self exportedIdentifiersDo: [ :identifier |
		identifiers add: identifier ].
	^ identifiers asArray
]

{ #category : 'enumerating' }
ViennaExportComponentNode >> exportedIdentifiersDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'testing' }
ViennaExportComponentNode >> exportsIdentifier: aString [

	self exportedIdentifiersDo: [ :identifier |
		identifier = aString ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'removing' }
ViennaExportComponentNode >> removeIdentifier: aString [

	^ self subclassResponsibility
]
