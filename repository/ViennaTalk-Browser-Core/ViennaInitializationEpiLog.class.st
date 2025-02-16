Class {
	#name : 'ViennaInitializationEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'#state => HiDePersistencySlot loader: #hideLoadState'
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
ViennaInitializationEpiLog >> hideLoad: aFileReference [

	super hideLoad: aFileReference.
	self hideLoadState: aFileReference
]

{ #category : 'hideho-operations' }
ViennaInitializationEpiLog >> hideLoadState [

	self hideBaseDirectoryDo: [ :ref | self hideLoadState: ref ]
]

{ #category : 'hideho-operations' }
ViennaInitializationEpiLog >> hideLoadState: aFileReference [

	aFileReference / 'state.json' ifExists: [ :ref |
		ref readStreamDo: [ :stream | state := STONJSON fromStream: stream ] ]
]

{ #category : 'hideho-operations' }
ViennaInitializationEpiLog >> hideSave: aFileReference [

	super hideSave: aFileReference.
	state ifNotNil: [
		(aFileReference / 'state.json')
			ensureDelete;
			writeStreamDo: [ :stream | STONJSON put: state onStream: stream ] ]
]

{ #category : 'initialization' }
ViennaInitializationEpiLog >> initialize [

	self class initializeSlots: self.
	super initialize.
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
