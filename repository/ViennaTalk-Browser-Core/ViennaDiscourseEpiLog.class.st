Class {
	#name : 'ViennaDiscourseEpiLog',
	#superclass : 'ViennaEpiLog',
	#instVars : [
		'#filename => HiDePersistencySlot loader: #hideLoadFilename',
		'#content => HiDePersistencySlot loader: #hideLoadContent'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaDiscourseEpiLog class >> after: aViennaEpiLog filename: aString content: anotherString [

	^ (self after: aViennaEpiLog)
		  filename: aString;
		  content: anotherString;
		  yourself
]

{ #category : 'accessing' }
ViennaDiscourseEpiLog class >> metadataName [

	^ 'Discourse'
]

{ #category : 'accessing' }
ViennaDiscourseEpiLog >> content [

	^ content
]

{ #category : 'accessing' }
ViennaDiscourseEpiLog >> content: aString [

	content := aString
]

{ #category : 'accessing' }
ViennaDiscourseEpiLog >> diffSetFromPred [

	| diffSet epiLog |
	diffSet := ViennaNodeDiffSet new.
	epiLog := self.
	[
		epiLog := epiLog pred.
		epiLog notNil ] whileTrue: [
			epiLog modifiedDiscoursesDo: [ :f :c |
					filename = f ifTrue: [
							diffSet changes add: (ViennaDiscourseChange filename: filename from: c to: content).
							^ diffSet ] ] ].
	diffSet changes add: (ViennaDiscourseChange filename: filename from: nil to: content).
	^ diffSet
]

{ #category : 'accessing' }
ViennaDiscourseEpiLog >> diffSetFromPrev [

	| diffSet epiLog |
	diffSet := ViennaNodeDiffSet new.
	epiLog := self.
	[
		epiLog := epiLog prev.
		epiLog notNil ] whileTrue: [
			epiLog modifiedDiscoursesDo: [ :f :c |
					filename = f ifTrue: [
							diffSet changes add: (ViennaDiscourseChange filename: filename from: c to: content).
							^ diffSet ] ] ].
	diffSet changes add: (ViennaDiscourseChange filename: filename from: nil to: content).
	^ diffSet
]

{ #category : 'accessing' }
ViennaDiscourseEpiLog >> filename [

	^ filename
]

{ #category : 'accessing' }
ViennaDiscourseEpiLog >> filename: aString [

	filename := aString
]

{ #category : 'hideho-operations' }
ViennaDiscourseEpiLog >> hideLoad: aFileReference [

	super hideLoad: aFileReference.
	self
		hideLoadFilename: aFileReference 
]

{ #category : 'hideho-operations' }
ViennaDiscourseEpiLog >> hideLoadContent [

	self hideBaseDirectoryDo: [ :ref | self hideLoadContent: ref ]
]

{ #category : 'hideho-operations' }
ViennaDiscourseEpiLog >> hideLoadContent: aFileReference [

	aFileReference / 'content.txt' ifExists: [ :ref | content := ref contents ]
]

{ #category : 'hideho-operations' }
ViennaDiscourseEpiLog >> hideLoadFilename [

	self hideBaseDirectoryDo: [ :ref | self hideLoadFilename: ref ]
]

{ #category : 'hideho-operations' }
ViennaDiscourseEpiLog >> hideLoadFilename: aFileReference [

	aFileReference / 'filename.txt' ifExists: [ :ref |
		filename := ref contents ]
]

{ #category : 'hideho-operations' }
ViennaDiscourseEpiLog >> hideSave: aFileReference [

	super hideSave: aFileReference.
	filename ifNotNil: [
			(aFileReference / 'filename.txt')
				ensureDelete;
				writeStreamDo: [ :stream | stream nextPutAll: filename ] ].
	content ifNotNil: [
			(aFileReference / 'content.txt')
				ensureDelete;
				writeStreamDo: [ :stream | stream nextPutAll: content ] ]
]

{ #category : 'initialization' }
ViennaDiscourseEpiLog >> initialize [
	"The following line is mandatory to support the implementation of ObservableSlot. Do not remove it if you continue to get your class using observable slots."

	self class initializeSlots: self.
	super initialize.
]

{ #category : 'testing' }
ViennaDiscourseEpiLog >> isDiscourseEpiLog [

	^ true
]

{ #category : 'testing' }
ViennaDiscourseEpiLog >> isRemovable [

	^ true
]

{ #category : 'enumerating' }
ViennaDiscourseEpiLog >> modifiedDiscoursesDo: aBlock [

	aBlock cull: filename cull: content
]

{ #category : 'printing' }
ViennaDiscourseEpiLog >> printOn: aStream [

	aStream nextPutAll: 'Edit'.
	filename ifNotNil: [
			aStream
				nextPutAll: ' ';
				nextPutAll: filename asString ]
]
