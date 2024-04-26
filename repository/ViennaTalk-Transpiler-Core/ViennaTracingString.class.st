Class {
	#name : #ViennaTracingString,
	#superclass : #String,
	#instVars : [
		'string',
		'sources'
	],
	#category : #'ViennaTalk-Transpiler-Core'
}

{ #category : #'instance creation' }
ViennaTracingString class >> fromString: aString [
	^ super basicNew
		initialize;
		setString: aString
]

{ #category : #'instance creation' }
ViennaTracingString class >> new [
	^ self basicNew
		initialize;
		setString: String new
]

{ #category : #'instance creation' }
ViennaTracingString class >> new: anInteger [
	^ self basicNew
		initialize;
		setString: (String new: anInteger)
]

{ #category : #'instance creation' }
ViennaTracingString class >> string: aString sources: aCollection [
	^ self basicNew
		setString: aString;
		setSources: aCollection
]

{ #category : #copying }
ViennaTracingString >> , aString [
	^ aString isViennaTracingString
		ifTrue: [ | size newSources |
			size := string size.
			newSources := OrderedCollection new: sources size + aString sources size.
			newSources addAll: sources.
			aString sources do: [ :assoc | newSources add: assoc key + size -> assoc value ].
			self class string: string , aString string sources: newSources ]
		ifFalse: [ self class string: string , aString sources: sources copy]
]

{ #category : #comparing }
ViennaTracingString >> = anObject [
	^ anObject = string
]

{ #category : #converting }
ViennaTracingString >> asByteArray [

	^ string asByteArray
]

{ #category : #converting }
ViennaTracingString >> asString [
	^ string
]

{ #category : #converting }
ViennaTracingString >> asViennaTracingString [
	^ self
]

{ #category : #converting }
ViennaTracingString >> asViennaTracingString: anObject [
	sources add: (1 to: string size) -> anObject
]

{ #category : #accessing }
ViennaTracingString >> at: anInteger [
	^ string at: anInteger
]

{ #category : #accessing }
ViennaTracingString >> at: anInteger put: aCharacter [
	^ string at: anInteger put: aCharacter
]

{ #category : #accessing }
ViennaTracingString >> basicAt: anInteger [
	^ (string at: anInteger) asciiValue
]

{ #category : #accessing }
ViennaTracingString >> byteAt: index [
	^ string byteAt: index
]

{ #category : #accessing }
ViennaTracingString >> byteAt: index put: value [
	^ string byteAt: index put: value
]

{ #category : #accessing }
ViennaTracingString >> byteSize [
	^ string byteSize
]

{ #category : #copying }
ViennaTracingString >> copyFrom: start to: end [
	| newSources |
	newSources := OrderedCollection new: sources size.
	sources
		do: [ :assoc | 
			| newStart newEnd |
			newStart := start max: assoc key first.
			newEnd := end min: assoc key last.
			newStart <= newEnd
				ifTrue: [ newSources add: (newStart - start + 1 to: newEnd - start + 1) -> assoc value ] ].
	^ self class string: (string copyFrom: start to: end) sources: newSources
]

{ #category : #streaming }
ViennaTracingString >> cr [
	^ self nextPut: Character cr
]

{ #category : #comparing }
ViennaTracingString >> hash [
	^ string hash
]

{ #category : #'initialize-release' }
ViennaTracingString >> initialize [
	super initialize.
	sources := OrderedCollection new
]

{ #category : #accessing }
ViennaTracingString >> intervalForSource: anObject [

	^ sources
		  detect: [ :assoc | assoc value == anObject ]
		  ifNone: [ (0 to: -1) -> anObject ]
]

{ #category : #testing }
ViennaTracingString >> isViennaTracingString [
	^ true
]

{ #category : #copying }
ViennaTracingString >> join: aCollection [
	| newSources offset |
	newSources := OrderedCollection
		new:
			(aCollection size - 1) * string size
				+
					(aCollection
						inject: 0
						into: [ :sum :each | sum + (each ifNil: [ 0 ] ifNotNil: [ each size ]) ]).
	offset := 0.
	aCollection
		do: [ :each | 
			each isViennaTracingString
				ifTrue: [ each sources do: [ :assoc | newSources add: assoc key + offset -> assoc value ] ].
			each ifNotNil: [ offset := offset + each size ] ]
		separatedBy: [ sources do: [ :assoc | newSources add: assoc key + offset -> assoc value ].
			offset := offset + string size ].
	^ self class string: (string join: (aCollection collect: #asString)) sources: newSources
]

{ #category : #accessing }
ViennaTracingString >> mergeSources [
	| newSources |
	newSources := OrderedCollection new: sources size.
	sources
		reverseDo: [ :assoc | 
			| source |
			source := assoc value.
			(newSources anySatisfy: [ :a | source == a value ])
				ifFalse: [ | intervals |
					intervals := sources
						select: [ :a | source == a value ]
						thenCollect: #key.
					newSources
						add:
							((intervals collect: #first) min to: (intervals collect: #last) max)
								-> source ] ].
	sources := newSources reverse
]

{ #category : #streaming }
ViennaTracingString >> nextPut: aCharacter [
	string := string copyWith: aCharacter
]

{ #category : #streaming }
ViennaTracingString >> nextPutAll: aString [
	aString isViennaTracingString
		ifTrue: [ | size |
			size := string size.
			sources addAll: (aString sources collect: [ :assoc | assoc key + size -> assoc value ]).
			string := string , aString string ]
		ifFalse: [ string := string , aString ]
]

{ #category : #accessing }
ViennaTracingString >> nodeAt: anInteger ifAbsent: errorBlock [
	sources
		do: [ :assoc | 
			((assoc key includes: anInteger) and: [ assoc value isViennaNode ])
				ifTrue: [ ^ assoc value ] ].
	^ errorBlock value
]

{ #category : #accessing }
ViennaTracingString >> nodeContaining: anInterval ifAbsent: errorBlock [
	| start end nodes |
	start := anInterval first.
	end := anInterval
		ifEmpty: [ start := start - 1 ]
		ifNotEmpty: [ anInterval last ].
	nodes := OrderedCollection new.
	sources
		do: [ :assoc | 
			((assoc key includes: start) and: [ assoc value isViennaNode ])
				ifTrue: [ nodes add: assoc value ] ].
	start + 1 to: end do: [ :index | 
		| newNodes |
		newNodes := OrderedCollection new: nodes size.
		sources
			do: [ :assoc | 
				((assoc key includes: index) and: [ nodes includes: assoc value ])
					ifTrue: [ newNodes add: assoc value ] ].
		nodes := newNodes ].
	^ nodes ifNotEmpty: #first ifEmpty: [ errorBlock value ]
]

{ #category : #accessing }
ViennaTracingString >> nodesContaining: anInterval [
	| start end |
	start := anInterval first.
	end := anInterval
		ifEmpty: [ start := start - 1 ]
		ifNotEmpty: [ anInterval last ].
	^ sources
		select: [ :assoc | assoc key first <= end and: [ assoc key last >= start ] ]
		thenCollect: #value
]

{ #category : #copying }
ViennaTracingString >> postCopy [
	string := string copy.
	sources := sources copy
]

{ #category : #'as yet unclassified' }
ViennaTracingString >> scanCharactersFrom: anInteger to: anInteger2 with: aCompositionScanner rightX: anInteger4 font: aLogicalFont [

	^ string
		  scanCharactersFrom: anInteger
		  to: anInteger2
		  with: aCompositionScanner
		  rightX: anInteger4
		  font: aLogicalFont
]

{ #category : #private }
ViennaTracingString >> setSources: aCollection [
	sources := aCollection
]

{ #category : #private }
ViennaTracingString >> setString: aString [
	string := aString
]

{ #category : #accessing }
ViennaTracingString >> size [
	^ string size
]

{ #category : #accessing }
ViennaTracingString >> sourceAt: anInteger ifAbsent: errorBlock [
	sources
		do: [ :assoc | 
			(assoc key includes: anInteger)
				ifTrue: [ ^ assoc value ] ].
	^ errorBlock value
]

{ #category : #accessing }
ViennaTracingString >> sources [
	^ sources
]

{ #category : #accessing }
ViennaTracingString >> sourcesAt: anInteger [
	^ sources
		select: [ :assoc | assoc key includes: anInteger ]
		thenCollect: #value
]

{ #category : #streaming }
ViennaTracingString >> space [
	self nextPut: Character space
]

{ #category : #accessing }
ViennaTracingString >> string [
	^ string
]

{ #category : #accessing }
ViennaTracingString >> writeStream [
	^ self
]
