Class {
	#name : 'ViennaRevertionEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'destination'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaRevertionEpiLog class >> after: aViennaEpiLog destination: anotherViennaEpiLog [

	^ (self after: aViennaEpiLog)
		  destination: anotherViennaEpiLog;
		  yourself
]

{ #category : 'accessing' }
ViennaRevertionEpiLog class >> metadataName [

	^ 'Reversion'
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> basicPred [

	^ destination
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> basicPred: aViennaEpiLog [

	destination := aViennaEpiLog
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> destination [

	^ destination
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> destination: aViennaEpiLog [

	destination := aViennaEpiLog
]

{ #category : 'testing' }
ViennaRevertionEpiLog >> hasChangeAt: aString module: anotherString [

	^ ((destination specification moduleNamed: anotherString) ifNotNil: [
		   :m | m resolveIdentifier: aString ])
	  ~=
		  ((prev specification moduleNamed: anotherString) ifNotNil: [ :m |
			   m resolveIdentifier: aString ])
]

{ #category : 'testing' }
ViennaRevertionEpiLog >> hasChangeAtModule: aString [

	^ (destination specification moduleNamed: aString)
	  ~= (prev specification moduleNamed: aString)
]

{ #category : 'testing' }
ViennaRevertionEpiLog >> hasSpecificationChange [

	^ destination specification ~= prev specification
]

{ #category : 'testing' }
ViennaRevertionEpiLog >> hasStateChange [

	^ destination state ~= prev state
]

{ #category : 'hideho-operations' }
ViennaRevertionEpiLog >> hideLoad: aFileReference storage: aHiDeStorage [

	hideMetadata
		at: 'destination'
		ifPresent: [ :id | destination := aHiDeStorage chronicleAt: id ]
]

{ #category : 'hideho-operations' }
ViennaRevertionEpiLog >> hideMetadataLoaded [

	super hideMetadataLoaded.
	hideMetadata
		at: 'destination'
		ifPresent: [ :id | destination := hideStorage chronicleAt: id ]
]

{ #category : 'hideho-operations' }
ViennaRevertionEpiLog >> hideUpdateMetadataStorage: aHiDeStorage [

	super hideUpdateMetadataStorage: aHiDeStorage.
	destination ifNotNil: [
		destination hideStorage = aHiDeStorage ifFalse: [
			hideStorage chronicleSave: destination ].
		hideMetadata
			at: 'destination'
			put: destination hideMetadata identity ]
]

{ #category : 'testing' }
ViennaRevertionEpiLog >> isPredEpiLog [

	^ false
]

{ #category : 'testing' }
ViennaRevertionEpiLog >> isRevertionEpiLog [

	^ true
]

{ #category : 'printing' }
ViennaRevertionEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Revert to "'.
	destination printOn: aStream.
	aStream nextPut: $"
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> revertDestination [

	^ destination
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> specification [

	^ destination specification
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> state [

	^ destination state
]
