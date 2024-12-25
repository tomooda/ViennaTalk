Class {
	#name : 'ViennaTopLevelDefinitionNodeChange',
	#superclass : 'ViennaAbstractNodeChange',
	#category : 'ViennaTalk-Browser-Core-Diff',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Diff'
}

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
	aStream
		nextPutAll: '        ';
		nextPutAll: (node section ifNotNil: #sectionName ifNil: ['state']);
		space;
		nextPutAll: (', ' join: node identifiers)
]
