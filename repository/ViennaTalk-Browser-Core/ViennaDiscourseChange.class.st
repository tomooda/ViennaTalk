Class {
	#name : 'ViennaDiscourseChange',
	#superclass : 'Object',
	#instVars : [
		'from',
		'to',
		'filename',
		'sourceDiffText'
	],
	#category : 'ViennaTalk-Browser-Core-Diff',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Diff'
}

{ #category : 'instance creation' }
ViennaDiscourseChange class >> filename: aString from: aStringOrNil to: anotherStringOrNil [

	^ self new
		  filename: aString;
		  setFrom: aStringOrNil to: anotherStringOrNil;
		  yourself
]

{ #category : 'utilities' }
ViennaDiscourseChange class >> flushSourceDiffText [

	<script: 'self flushSourceDiffText'>
	self allSubclassesDo: [ :c |
		c allInstancesDo: [ :i | i flushSourceDiffText ] ]
]

{ #category : 'instance creation' }
ViennaDiscourseChange class >> from: aStringOrNil to: anotherStringOrNil [

	^ self new
		  setFrom: aStringOrNil to: anotherStringOrNil;
		  yourself
]

{ #category : 'operations' }
ViennaDiscourseChange >> applyDiscourseTo: aFileReference [

	| ref |
	filename ifNil: [ ^ self ].
	ref := aFileReference / filename.
	to ifNotNil: [ ref writeStreamDo: [ :stream | stream nextPutAll: to withPlatformLineEndings ] ] ifNil: [ ref ensureDelete ]
]

{ #category : 'operations' }
ViennaDiscourseChange >> applyTo: aViennaModularDocumentNode [

	
]

{ #category : 'copying' }
ViennaDiscourseChange >> copyWithFrom: aViennaNode to: anotherViennaNode [

	^ self class filename: filename from: aViennaNode to: anotherViennaNode
]

{ #category : 'accessing' }
ViennaDiscourseChange >> filename [

	^ filename
]

{ #category : 'accessing' }
ViennaDiscourseChange >> filename: aString [

	filename := aString
]

{ #category : 'private' }
ViennaDiscourseChange >> flushSourceDiffText [

	sourceDiffText := nil
]

{ #category : 'accessing' }
ViennaDiscourseChange >> from [

	^ from
]

{ #category : 'controlling' }
ViennaDiscourseChange >> ifDiscourseChanges: aBlock [

	self ifNotEmpty: aBlock
]

{ #category : 'controlling' }
ViennaDiscourseChange >> ifNodeChanges: aBlock [
]

{ #category : 'controlling' }
ViennaDiscourseChange >> ifNotEmpty: aBlock [

	from = to ifFalse: [ aBlock cull: self ]
]

{ #category : 'testing' }
ViennaDiscourseChange >> isViennaModuleNodeChange [

	^ false
]

{ #category : 'testing' }
ViennaDiscourseChange >> isViennaTopLevelDefinitionNodeChange [

	^ false
]

{ #category : 'testing' }
ViennaDiscourseChange >> overwrites: aViennaAbstractNodeChange [

	^ self class = aViennaAbstractNodeChange class and: [
		  from = aViennaAbstractNodeChange to ]
]

{ #category : 'printing' }
ViennaDiscourseChange >> printNames [

	^ String streamContents: [ :stream | self printNamesOn: stream ]
]

{ #category : 'printing' }
ViennaDiscourseChange >> printNamesOn: aStream [

	filename ifNotNil: [ aStream nextPutAll: filename ]
]

{ #category : 'printing' }
ViennaDiscourseChange >> printOn: aStream [

	self printSummaryOn: aStream.
	aStream
		space;
		nextPutAll: filename
]

{ #category : 'printing' }
ViennaDiscourseChange >> printSummary [

	^ String streamContents: [ :stream | self printSummaryOn: stream ]
]

{ #category : 'printing' }
ViennaDiscourseChange >> printSummaryOn: aStream [

	from
		ifNil: [ to ifNotNil: [ aStream nextPutAll: 'added' ] ]
		ifNotNil: [
			to
				ifNil: [ aStream nextPutAll: 'removed' ]
				ifNotNil: [ aStream nextPutAll: 'modified' ] ]
]

{ #category : 'private' }
ViennaDiscourseChange >> setFrom: aStringOrNil to: anotherStringOrNil [

	from := aStringOrNil.
	to := anotherStringOrNil
]

{ #category : 'printing' }
ViennaDiscourseChange >> sourceDiffText [

	^ sourceDiffText ifNil: [ sourceDiffText := ViennaTextDiffBuilder buildDisplayPatchFrom: (from ifNil: [ '' ]) to: (to ifNil: [ '' ]) ]
]

{ #category : 'accessing' }
ViennaDiscourseChange >> to [

	^ to
]
