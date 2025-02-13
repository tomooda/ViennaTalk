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

	^ self destination
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> basicPred: aViennaEpiLog [

	destination := aViennaEpiLog
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> destination [

	destination ifNil: [ self hideLoad ].
	^ destination
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> destination: aViennaEpiLog [

	destination := aViennaEpiLog
]

{ #category : 'testing' }
ViennaRevertionEpiLog >> hasChangeAt: aString module: anotherString [

	^ ((self destination specification moduleNamed: anotherString)
		   ifNotNil: [ :m | m resolveIdentifier: aString ])
	  ~=
		  ((self prev specification moduleNamed: anotherString) ifNotNil: [
			   :m | m resolveIdentifier: aString ])
]

{ #category : 'testing' }
ViennaRevertionEpiLog >> hasChangeAtModule: aString [

	^ (self destination specification moduleNamed: aString)
	  ~= (self prev specification moduleNamed: aString)
]

{ #category : 'testing' }
ViennaRevertionEpiLog >> hasSpecificationChange [

	^ self destination specification ~= self prev specification
]

{ #category : 'testing' }
ViennaRevertionEpiLog >> hasStateChange [

	^ self destination state ~= self prev state
]

{ #category : 'hideho-operations' }
ViennaRevertionEpiLog >> hideLoad: aFileReference storage: aHiDeStorage [

	hideMetadata
		at: 'destination'
		ifPresent: [ :id | destination := aHiDeStorage chronicleAt: id ]
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
ViennaRevertionEpiLog >> isRevertionEpiLog [

	^ true
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> pred [

	^ self destination isRevertionEpiLog
		  ifTrue: [ self destination pred ]
		  ifFalse: [ self destination ]
]

{ #category : 'printing' }
ViennaRevertionEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Revert to "'.
	self destination printOn: aStream.
	aStream nextPut: $"
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> revertDestination [

	^ self destination
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> specification [

	^ self destination specification
]

{ #category : 'accessing' }
ViennaRevertionEpiLog >> state [

	^ self destination state
]
