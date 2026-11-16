Class {
	#name : 'ViennaDiscourseModificationEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'#filename => HiDePersistencySlot loader: #hideLoadFilename'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaDiscourseModificationEpiLog class >> after: aViennaEpiLog filename: aString [

	^ (self after: aViennaEpiLog)
		  filename: aString;
		  yourself
]

{ #category : 'accessing' }
ViennaDiscourseModificationEpiLog class >> metadataName [

	^ 'Discourse'
]

{ #category : 'accessing' }
ViennaDiscourseModificationEpiLog >> filename [

	^ filename
]

{ #category : 'accessing' }
ViennaDiscourseModificationEpiLog >> filename: aString [

	filename := aString
]

{ #category : 'hideho-operations' }
ViennaDiscourseModificationEpiLog >> hideLoad: aFileReference [

	super hideLoad: aFileReference.
	self
		hideLoadFilename: aFileReference 
]

{ #category : 'hideho-operations' }
ViennaDiscourseModificationEpiLog >> hideLoadFilename [

	self hideBaseDirectoryDo: [ :ref | self hideLoadFilename: ref ]
]

{ #category : 'hideho-operations' }
ViennaDiscourseModificationEpiLog >> hideLoadFilename: aFileReference [

	aFileReference / 'filename.txt' ifExists: [ :ref |
		filename := ref contents ]
]

{ #category : 'hideho-operations' }
ViennaDiscourseModificationEpiLog >> hideSave: aFileReference [

	super hideSave: aFileReference.
	filename ifNotNil: [
			(aFileReference / 'filename.txt')
				ensureDelete;
				writeStreamDo: [ :stream | stream nextPutAll: filename ] ]
]

{ #category : 'initialization' }
ViennaDiscourseModificationEpiLog >> initialize [
	"The following line is mandatory to support the implementation of ObservableSlot. Do not remove it if you continue to get your class using observable slots."

	self class initializeSlots: self.
	super initialize.
]

{ #category : 'testing' }
ViennaDiscourseModificationEpiLog >> isDiscourseModificationEpiLog [

	^ true
]

{ #category : 'testing' }
ViennaDiscourseModificationEpiLog >> isRemovable [

	self hasSpecificationChange ifFalse: [ ^ true ].
	hideStorage chronicle do: [ :epiLog |
		epiLog prev == self ifTrue: [
			epiLog isSpecificationModificationEpiLog ifFalse: [ ^ false ] ].
		epiLog basicPred == self ifTrue: [
			epiLog isSpecificationModificationEpiLog ifFalse: [ ^ false ] ] ].
	^ true
]

{ #category : 'printing' }
ViennaDiscourseModificationEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Doc'
]
