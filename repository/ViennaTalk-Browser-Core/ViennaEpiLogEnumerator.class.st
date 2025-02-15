Class {
	#name : 'ViennaEpiLogEnumerator',
	#superclass : 'Object',
	#classInstVars : [
		'current'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'accessing' }
ViennaEpiLogEnumerator class >> current [

	^ current ifNil: [ current := self new ]
]

{ #category : 'testing' }
ViennaEpiLogEnumerator class >> isAbstract [

	^ self == ViennaEpiLogEnumerator
]

{ #category : 'testing' }
ViennaEpiLogEnumerator >> accepts: aViennaEpiLog [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaEpiLogEnumerator >> arrayFrom: aViennaEpiLog [

	^ Array streamContents: [ :stream |
		  self from: aViennaEpiLog do: [ :epilog | stream nextPut: epilog ] ]
]

{ #category : 'accessing' }
ViennaEpiLogEnumerator >> diffSet: aViennaEpiLog [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
ViennaEpiLogEnumerator >> from: aViennaEpiLog do: aBlock [

	| epilog |
	epilog := aViennaEpiLog.
	[ epilog notNil ] whileTrue: [
		(self accepts: epilog) ifTrue: [ aBlock value: epilog ].
		epilog := self prevFrom: epilog ]
]

{ #category : 'accessing' }
ViennaEpiLogEnumerator >> prevFrom: aViennaEpiLog [

	^ self subclassResponsibility
]
