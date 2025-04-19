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
ViennaHiDeStorage >> garbageCollect [

	| agenda garbages |
	agenda := OrderedCollection with: self chronicleTail.
	narratives valuesDo: [ :narrative | agenda addAll: narrative asArray ].
	garbages := chronicle values asSet.
	[ agenda notEmpty ] whileTrue: [
		| epiLog |
		epiLog := agenda removeLast.
		(garbages includes: epiLog) ifTrue: [
			garbages remove: epiLog ifAbsent: [  ].
			epiLog prev ifNotNil: [ :prev | agenda addLast: prev ].
			epiLog pred ifNotNil: [ :pred | agenda addLast: pred ] ] ].
	garbages do: [ :epiLog | self chronicleRemove: epiLog ]
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
