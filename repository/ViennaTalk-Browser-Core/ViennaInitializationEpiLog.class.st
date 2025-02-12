Class {
	#name : 'ViennaInitializationEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'state'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaInitializationEpiLog class >> after: aViennaEpiLog state: aDictionary [

	^ (self after: aViennaEpiLog)
		  state: aDictionary;
		  yourself
]

{ #category : 'accessing' }
ViennaInitializationEpiLog class >> metadataName [

	^ 'Initialization'
]

{ #category : 'accessing' }
ViennaInitializationEpiLog >> defaultComment [

	^ 'Init'
]

{ #category : 'testing' }
ViennaInitializationEpiLog >> hasStateChange [

	^ true
]

{ #category : 'hideho-operations' }
ViennaInitializationEpiLog >> hideLoad: aFileReference storage: aHiDeStorage [

	super hideLoad: aFileReference storage: aHiDeStorage.
	aFileReference / 'state.json' ifExists: [ :ref |
		ref readStreamDo: [ :stream | state := STONJSON fromStream: stream ] ]
]

{ #category : 'hideho-operations' }
ViennaInitializationEpiLog >> hideSave: aFileReference storage: aHiDeStorage [

	super hideSave: aFileReference storage: aHiDeStorage.
	state ifNotNil: [
		(aFileReference / 'state.json')
			ensureDelete;
			writeStreamDo: [ :stream | STONJSON put: state onStream: stream ] ]
]

{ #category : 'testing' }
ViennaInitializationEpiLog >> isInitializationEpiLog [

	^ true
]

{ #category : 'printing' }
ViennaInitializationEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Init'
]

{ #category : 'accessing' }
ViennaInitializationEpiLog >> state [

	^ state
]

{ #category : 'accessing' }
ViennaInitializationEpiLog >> state: aDictionary [

	state := aDictionary
]
