Class {
	#name : 'ViennaHiDeStorage',
	#superclass : 'HiDeStorage',
	#category : 'ViennaTalk-Browser-Core-HiDeHo',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'HiDeHo'
}

{ #category : 'instance creation' }
ViennaHiDeStorage class >> for: aFileReferenceOrNil [

	| basepath |
	basepath := aFileReferenceOrNil
		            ifNotNil: [
			            ((aFileReferenceOrNil isFile
				              ifTrue: [ aFileReferenceOrNil parent ]
				              ifFalse: [ aFileReferenceOrNil ]) / '.hideho')
				            ensureCreateDirectory;
				            yourself ]
		            ifNil: [ FileSystem memory root ].
	^ self new
		  basepath: basepath;
		  loadChronicle;
		  yourself
]

{ #category : 'instance creation' }
ViennaHiDeStorage class >> memory [

	^ self new
		  basepath: FileSystem memory root;
		  yourself
]

{ #category : 'operations' }
ViennaHiDeStorage >> chronicleAt: aString ifAbsent: errorBlock [

	^ chronicle at: aString ifAbsent: errorBlock
]

{ #category : 'operations' }
ViennaHiDeStorage >> chronicleSuchThat: aBlock [

	| payloads |
	payloads := chronicle values select: [ :payload |
		            aBlock value: payload hideMetadata ].
	^ payloads asSortedCollection: [ :newer :older |
		  older hideMetadata timestamp <= newer hideMetadata timestamp ]
]

{ #category : 'operations' }
ViennaHiDeStorage >> chronicleTail [

	| tail tailtime |
	chronicle ifEmpty: [ ^ nil ].
	tail := chronicle values anyOne.
	tailtime := tail hideMetadata timestamp.
	chronicle valuesDo: [ :persistency |
		| time |
		tailtime < (time := persistency hideMetadata timestamp) ifTrue: [
			tail := persistency.
			tailtime := time ] ].
	^ tail
]

{ #category : 'operations' }
ViennaHiDeStorage >> loadChronicle [

	super loadChronicle.
	chronicle valuesDo: [ :payload | payload hideMetadataLoaded ]
]

{ #category : 'class access' }
ViennaHiDeStorage >> payloadClassFor: aHiDeMetadata [

	^ ViennaEpiLog classFor: (aHiDeMetadata at: 'class')
]
