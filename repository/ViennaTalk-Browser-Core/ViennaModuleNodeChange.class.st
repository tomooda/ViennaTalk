Class {
	#name : 'ViennaModuleNodeChange',
	#superclass : 'ViennaAbstractNodeChange',
	#category : 'ViennaTalk-Browser-Core-Diff',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Diff'
}

{ #category : 'operations' }
ViennaModuleNodeChange >> applyTo: aViennaDocumentNode [

	| oldNode |
	oldNode := from ifNil: [
		           aViennaDocumentNode ensureModuleNamed:
			           to module identifier ].
	oldNode document == aViennaDocumentNode ifFalse: [ ^ self ].
	to
		ifNotNil: [ oldNode parent replace: oldNode with: to copyFragment ]
		ifNil: [ oldNode parent remove: oldNode ]
]

{ #category : 'enumerating' }
ViennaModuleNodeChange >> changedGlobalNamesDo: aBlock [

	
]

{ #category : 'testing' }
ViennaModuleNodeChange >> isViennaModuleNodeChange [

	^ true
]

{ #category : 'printing' }
ViennaModuleNodeChange >> printNamesOn: aStream [

	aStream
		nextPutAll: 'module ';
		nextPutAll: (from ifNil: [ to ]) identifier
]
