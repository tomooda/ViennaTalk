Class {
	#name : 'ViennaOrderedSet',
	#superclass : 'OrderedCollection',
	#instVars : [
		'set'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Utilities',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Utilities'
}

{ #category : 'adding' }
ViennaOrderedSet >> addFirst: newObject [

	(set includes: newObject) ifFalse: [ super addFirst: newObject ].
	^ newObject
]

{ #category : 'adding' }
ViennaOrderedSet >> addLast: newObject [

	(set includes: newObject) ifFalse: [ super addLast: newObject ].
	^ newObject
]

{ #category : 'converting' }
ViennaOrderedSet >> asOrderedCollection [

	^ OrderedCollection withAll: self
]

{ #category : 'accessing' }
ViennaOrderedSet >> at: anInteger put: anObject [

	(set includes: anObject)
		ifTrue: [ self removeIndex: anInteger ]
		ifFalse: [
				set
					remove: (self at: anInteger) ifAbsent: [ ];
					add: anObject.
				super at: anInteger put: anObject ].
	^ anObject
]

{ #category : 'testing' }
ViennaOrderedSet >> includes: anObject [

	^ set includes: anObject
]

{ #category : 'private' }
ViennaOrderedSet >> insert: anObject before: spot [

	(set includes: anObject) ifFalse: [
		super insert: anObject before: spot ].
	^ anObject
]

{ #category : 'copying' }
ViennaOrderedSet >> postCopy [

	super postCopy.
	set := set copy
]

{ #category : 'copying' }
ViennaOrderedSet >> postCopyFrom: startIndex to: endIndex [

	super postCopyFrom: startIndex to: endIndex.
	set := self asSet
]

{ #category : 'removing' }
ViennaOrderedSet >> remove: oldObject ifAbsent: absentBlock [

	set remove: oldObject ifAbsent: [ ].
	^ super remove: oldObject ifAbsent: absentBlock
]

{ #category : 'removing' }
ViennaOrderedSet >> removeAllSuchThat: aBlock [

	[ super removeAllSuchThat: aBlock ] ensure: [ set := self asSet ]
]

{ #category : 'removing' }
ViennaOrderedSet >> removeDuplicates [
]

{ #category : 'removing' }
ViennaOrderedSet >> removeFirst [

	set remove: (self at: 1) ifAbsent: [ ].
	^ super removeFirst
]

{ #category : 'private' }
ViennaOrderedSet >> removeIndex: removedIndex [

	set remove: (self at: removedIndex) ifAbsent: [ ].
	^ super removeIndex: removedIndex
]

{ #category : 'removing' }
ViennaOrderedSet >> removeLast [

	set remove: (self at: self size) ifAbsent: [ ].
	^ super removeLast
]

{ #category : 'private' }
ViennaOrderedSet >> setCollection: anArray [

	super setCollection: anArray.
	set := Set new: anArray size
]

{ #category : 'private' }
ViennaOrderedSet >> setContents: anArray [

	super setContents: anArray.
	set := anArray asSet
]
