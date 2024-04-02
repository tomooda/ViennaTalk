Class {
	#name : #ViennaTopLevelDefinitionNodeChange,
	#superclass : #ViennaAbstractNodeChange,
	#category : #'ViennaTalk-Browser-Core-Diff'
}

{ #category : #printing }
ViennaTopLevelDefinitionNodeChange >> printNamesOn: aStream [

	| node |
	node := from ifNil: [ to ].
	aStream
		nextPutAll: '        ';
		nextPutAll: node section sectionName;
		space;
		nextPutAll: (', ' join: node identifiers)
]
