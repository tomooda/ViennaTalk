Class {
	#name : 'ViennaTopLevelDefinitionNodeChange',
	#superclass : 'ViennaAbstractNodeChange',
	#category : 'ViennaTalk-Browser-Core-Diff',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Diff'
}

{ #category : 'operations' }
ViennaTopLevelDefinitionNodeChange >> applyTo: aViennaDocumentNode [

	(from isNil or: [ from document == aViennaDocumentNode ]) ifFalse: [
		^ self ].
	to
		ifNotNil: [
			from
				ifNotNil: [ from parent replace: from with: to copyFragment ]
				ifNil: [
					to copyFragment addToModule:
						(aViennaDocumentNode ensureModuleNamed: to module identifier) ] ]
		ifNil: [ from ifNotNil: [ from parent remove: from ] ]
]

{ #category : 'enumerating' }
ViennaTopLevelDefinitionNodeChange >> changedGlobalNamesDo: aBlock [

	from ifNotNil: [ from globalNamesDo: aBlock ].
	to ifNotNil: [ to globalNamesDo: aBlock ]
]

{ #category : 'testing' }
ViennaTopLevelDefinitionNodeChange >> isViennaTopLevelDefinitionNodeChange [

	^ true
]

{ #category : 'printing' }
ViennaTopLevelDefinitionNodeChange >> printNamesOn: aStream [

	| node |
	node := from ifNil: [ to ].
	node ifNotNil: [
			aStream
				nextPutAll: '        ';
				nextPutAll:
					(node section ifNotNil: #sectionName ifNil: [ 'state' ]);
				space;
				nextPutAll: (', ' join: node identifiers) ]
]
