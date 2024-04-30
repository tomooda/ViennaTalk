Class {
	#name : 'ViennaTopLevelDefinitionNodeChange',
	#superclass : 'ViennaAbstractNodeChange',
	#category : 'ViennaTalk-Browser-Core-Diff',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Diff'
}

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
