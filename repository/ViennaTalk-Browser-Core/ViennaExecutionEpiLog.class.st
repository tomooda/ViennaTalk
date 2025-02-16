Class {
	#name : 'ViennaExecutionEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'#statement => HiDePersistencySlot loader: #hideLoadStatement',
		'#state => HiDePersistencySlot loader: #hideLoadState'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

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

	^ state notNil and: [ prev isNil or: [ prev state ~= state ] ]
]

{ #category : 'hideho-operations' }
ViennaExecutionEpiLog >> hideLoad: aFileReference [

	super hideLoad: aFileReference.
	self
		hideLoadStatement: aFileReference;
		hideLoadState: aFileReference
]

{ #category : 'hideho-operations' }
ViennaExecutionEpiLog >> hideLoadState [

	self hideBaseDirectoryDo: [ :ref | self hideLoadState: ref ]
]

{ #category : 'hideho-operations' }
ViennaExecutionEpiLog >> hideLoadState: aFileReference [

	aFileReference / 'state.json' ifExists: [ :ref |
		ref readStreamDo: [ :stream | state := STONJSON fromStream: stream ] ]
]

{ #category : 'hideho-operations' }
ViennaExecutionEpiLog >> hideLoadStatement [

	self hideBaseDirectoryDo: [ :ref | self hideLoadStatement: ref ]
]

{ #category : 'hideho-operations' }
ViennaExecutionEpiLog >> hideLoadStatement: aFileReference [

	aFileReference / 'statement.txt' ifExists: [ :ref |
		statement := ref contents ]
]

{ #category : 'hideho-operations' }
ViennaExecutionEpiLog >> hideSave: aFileReference [

	super hideSave: aFileReference.
	statement ifNotNil: [
		(aFileReference / 'statement.txt')
			ensureDelete;
			writeStreamDo: [ :stream | stream nextPutAll: statement ] ].
	state ifNotNil: [
		(aFileReference / 'state.json')
			ensureDelete;
			writeStreamDo: [ :stream | STONJSON put: state onStream: stream ] ]
]

{ #category : 'initialization' }
ViennaExecutionEpiLog >> initialize [

	self class initializeSlots: self.
	super initialize.
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

	^ state ifNil: [ prev ifNotNil: #state ifNil: [ Dictionary new ] ]
]

{ #category : 'accessing' }
ViennaExecutionEpiLog >> state: aDictionary [

	state := aDictionary
]

{ #category : 'accessing' }
ViennaExecutionEpiLog >> statement [

	^ statement
]

{ #category : 'accessing' }
ViennaExecutionEpiLog >> statement: aString [

	statement := aString
]
