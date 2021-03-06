Class {
	#name : #ViennaNode,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'label',
		'parent',
		'start',
		'end'
	],
	#category : #'ViennaTalk-Parser-Core'
}

{ #category : #'instance creation' }
ViennaNode class >> label: aString [
	^ (self new: 0)
		setLabel: aString;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 [
	^ (self new: 0)
		setLabel: aString;
		start: anInteger1 end: anInteger2;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 with: aViennaNode [
	^ (self new: 1)
		setLabel: aString;
		at: 1 put: aViennaNode;
		start: anInteger1 end: anInteger2;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 with: aViennaNode1 with: aViennaNode2 [
	^ (self new: 2)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		start: anInteger1 end: anInteger2;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 [
	^ (self new: 3)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		start: anInteger1 end: anInteger2;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 withAll: anArray [
	| node |
	node := self new: anArray size.
	node setLabel: aString.
	1 to: anArray size do: [ :index | node at: index put: (anArray at: index) ].
	node start: anInteger1 end: anInteger2.
	^ node
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode [
	^ (self new: 1)
		setLabel: aString;
		at: 1 put: aViennaNode;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 [
	^ (self new: 2)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 [
	^ (self new: 3)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 with: aViennaNode4 [
	^ (self new: 4)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		at: 4 put: aViennaNode4;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 with: aViennaNode4 with: aViennaNode5 [
	^ (self new: 5)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		at: 4 put: aViennaNode4;
		at: 5 put: aViennaNode5;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString withAll: anArray [
	| node |
	node := self new: anArray size.
	node setLabel: aString.
	1 to: anArray size do: [ :index | node at: index put: (anArray at: index) ].
	^ node
]

{ #category : #enumerating }
ViennaNode >> allDescendantsDo: aBlock [
	aBlock value: self.
	self
		do: [ :node | 
			node isViennaNode
				ifTrue: [ node allDescendantsDo: aBlock ] ]
]

{ #category : #enumerating }
ViennaNode >> allSatisfy: aBlock [
	self
		do: [ :node | 
			(aBlock value: node)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #converting }
ViennaNode >> asArray [
	| array |
	array := Array new: self size.
	1 to: self size do: [ :i | array at: i put: (self at: i) ].
	^ array
]

{ #category : #converting }
ViennaNode >> asArrayFrom: anInteger [
	^ self asArrayFrom: anInteger to: self size
]

{ #category : #converting }
ViennaNode >> asArrayFrom: anInteger1 to: anInteger2 [
	^ (anInteger1 to: anInteger2) collect: [ :i | self at: i ]
]

{ #category : #accessing }
ViennaNode >> at: anInteger put: anObject [
	(anObject isKindOf: ViennaNode)
		ifTrue: [ anObject parent: self ].
	^ super at: anInteger put: anObject
]

{ #category : #enumerating }
ViennaNode >> collect: aBlock [
	^ (1 to: self size) collect: [ :index | aBlock value: (self at: index) ]
]

{ #category : #enumerating }
ViennaNode >> detect: aBlock [
	self do: [ :node | (aBlock value: node) ifTrue: [ ^node ] ].
	^ NotFound signalFor: self
]

{ #category : #enumerating }
ViennaNode >> do: aBlock [
	1 to: self size do: [ :index | aBlock value: (self at: index) ]
]

{ #category : #accessing }
ViennaNode >> eighth [
	^ self at: 8
]

{ #category : #accessing }
ViennaNode >> end [
	^ end
]

{ #category : #accessing }
ViennaNode >> fifth [
	^ self at: 5
]

{ #category : #accessing }
ViennaNode >> first [
	^ self at: 1
]

{ #category : #accessing }
ViennaNode >> fourth [
	^ self at: 4
]

{ #category : #enumerating }
ViennaNode >> hasDescendantSuchThat: aBlock [
	self allDescendantsDo: [ :n | (aBlock value: n) ifTrue: [ ^true ] ].
	^ false
]

{ #category : #accessing }
ViennaNode >> highlightedSource [
	^ self source
		in: [ :source | 
			ViennaVDMHighlighter new
				text: source asString asText;
				parse: source asString;
				text ]
]

{ #category : #controlling }
ViennaNode >> ifEmpty: aBlock [
	^ self isEmpty
		ifTrue: [ aBlock cull: self ]
		ifFalse: [ self ]
]

{ #category : #controlling }
ViennaNode >> ifNotEmpty: aBlock [
	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #testing }
ViennaNode >> isEmpty [
	^ self size = 0
]

{ #category : #testing }
ViennaNode >> isViennaNode [
	^ true
]

{ #category : #accessing }
ViennaNode >> label [
	^ label
]

{ #category : #accessing }
ViennaNode >> module [
	^ self parentLabelled: 'Module' ifAbsent: [ nil ]
]

{ #category : #accessing }
ViennaNode >> ninth [
	^ self at: 9
]

{ #category : #testing }
ViennaNode >> notEmpty [
	^ self isEmpty not
]

{ #category : #accessing }
ViennaNode >> parent [
	^ parent
]

{ #category : #accessing }
ViennaNode >> parent: aViennaNode [
	parent := aViennaNode
]

{ #category : #accessing }
ViennaNode >> parentLabelled: aString ifAbsent: errorBlock [
	self
		parentsDo: [ :node | 
			node label = aString
				ifTrue: [ ^ node ] ].
	^ errorBlock value
]

{ #category : #enumerating }
ViennaNode >> parentsDo: aBlock [
	| node |
	node := self.
	[ node notNil ]
		whileTrue: [ 
			aBlock value: node.
			node := node parent ]
]

{ #category : #printing }
ViennaNode >> printOn: aStream [
	| substrings |
	aStream
		nextPut: $(;
		nextPutAll: label asString;
		nextPut: Character space.
	substrings := self collect: #printString.
	((substrings contains: [ :string | string includes: Character cr ]) or: [( {0}, (substrings collect: #size)) sum > 50 ])
		ifTrue: [ 
			substrings
				do: [ :string | 
					aStream nextPut: Character cr.
					string lines
						do: [ :line | 
							aStream
								nextPutAll: '  ';
								nextPutAll: line ]
						separatedBy: [ aStream nextPut: Character cr ] ] ]
		ifFalse: [ substrings do: [ :string | aStream nextPutAll: string ] separatedBy: [ aStream nextPut: Character space ] ].
	aStream nextPut: $)
]

{ #category : #accessing }
ViennaNode >> second [
	^ self at: 2
]

{ #category : #private }
ViennaNode >> setLabel: aString [
	label := aString
]

{ #category : #accessing }
ViennaNode >> seventh [
	^ self at: 7
]

{ #category : #accessing }
ViennaNode >> sixth [
	^ self at: 6
]

{ #category : #accessing }
ViennaNode >> source [
	^ ViennaVDMFormatter format: self
]

{ #category : #accessing }
ViennaNode >> start [
	^ start
]

{ #category : #accessing }
ViennaNode >> start: anInteger1 end: anInteger2 [
	start := anInteger1.
	end := anInteger2
]

{ #category : #accessing }
ViennaNode >> stateVariablesDo: aBlock [
	(self parentLabelled: 'DefinitionBlock' ifAbsent: [ ^ self ]) parent
		do: [ :node | 
			node first label = 'StateDefinition'
				ifTrue: [ node first second do: [ :field | aBlock value: field first ] ] ]
]

{ #category : #printing }
ViennaNode >> storeOn: aStream [
	aStream
		nextPutAll: '(';
		nextPutAll: self class name;
		nextPutAll: ' label: '.
	label storeOn: aStream.
	aStream nextPutAll: ' withAll: {'.
	(1 to: self size) do: [ :index | (self at: index) storeOn: aStream ] separatedBy: [ aStream nextPutAll: ' . ' ].
	aStream nextPutAll: '})'
]

{ #category : #accessing }
ViennaNode >> third [
	^ self at: 3
]
