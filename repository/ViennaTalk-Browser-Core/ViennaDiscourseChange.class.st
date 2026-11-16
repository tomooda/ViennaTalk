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
		nextPutAll: (', ' join: (to ifNil: [ from ]) identifiers)
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

	^ sourceDiffText ifNil: [ sourceDiffText := TextDiffBuilder buildDisplayPatchFrom: (from ifNil: [ '' ]) to: (to ifNil: [ '' ]) ]
]

{ #category : 'accessing' }
ViennaDiscourseChange >> to [

	^ to
]
