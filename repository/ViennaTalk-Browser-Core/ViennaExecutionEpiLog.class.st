Class {
	#name : 'ViennaExecutionEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'statement',
		'state'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creaiton' }
ViennaExecutionEpiLog class >> after: aViennaEpiLog statement: aString [

	^ (self after: aViennaEpiLog)
		  statement: aString;
		  yourself
]

{ #category : 'instance creaiton' }
ViennaExecutionEpiLog class >> after: aViennaEpiLog statement: aString state: aDictionary [

	^ (self after: aViennaEpiLog)
		  statement: aString;
		  state: aDictionary;
		  yourself
]

{ #category : 'accessing' }
ViennaExecutionEpiLog class >> metadataName [

	^ 'Execution'
]

{ #category : 'testing' }
ViennaExecutionEpiLog >> hasStateChange [

	^ self state notNil and: [
		  self prev isNil or: [ self prev state ~= self state ] ]
]

{ #category : 'hideho-operations' }
ViennaExecutionEpiLog >> hideLoad: aFileReference storage: aHiDeStorage [

	super hideLoad: aFileReference storage: aHiDeStorage.
	aFileReference / 'statement.txt' ifExists: [ :ref |
		statement := ref contents ].
	aFileReference / 'state.json' ifExists: [ :ref |
		ref readStreamDo: [ :stream | state := STONJSON fromStream: stream ] ]
]

{ #category : 'hideho-operations' }
ViennaExecutionEpiLog >> hideSave: aFileReference storage: aHiDeStorage [

	super hideSave: aFileReference storage: aHiDeStorage.
	statement ifNotNil: [
		(aFileReference / 'statement.txt')
			ensureDelete;
			writeStreamDo: [ :stream | stream nextPutAll: statement ] ].
	state ifNotNil: [
		(aFileReference / 'state.json')
			ensureDelete;
			writeStreamDo: [ :stream | STONJSON put: state onStream: stream ] ]
]

{ #category : 'testing' }
ViennaExecutionEpiLog >> isExecutionEpiLog [

	^ true
]

{ #category : 'printing' }
ViennaExecutionEpiLog >> printOn: aStream [

	aStream
		nextPutAll: 'Exec ';
		nextPutAll: self statement
]

{ #category : 'accessing' }
ViennaExecutionEpiLog >> state [

	self statement.
	^ state ifNil: [
		  self prev ifNotNil: #state ifNil: [ Dictionary new ] ]
]

{ #category : 'accessing' }
ViennaExecutionEpiLog >> state: aDictionary [

	self state ~= aDictionary ifTrue: [ state := aDictionary ]
]

{ #category : 'accessing' }
ViennaExecutionEpiLog >> statement [

	statement ifNil: [ self hideLoad ].
	^ statement
]

{ #category : 'accessing' }
ViennaExecutionEpiLog >> statement: aString [

	statement := aString
]
