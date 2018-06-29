Class {
	#name : #ViennaModel,
	#superclass : #Object,
	#instVars : [
		'lock',
		'http',
		'specification',
		'state',
		'reader',
		'writer'
	],
	#category : 'ViennaTalk-Engine-Core'
}

{ #category : #defaults }
ViennaModel class >> defaultUrl [
	^ 'http://vdmpad.csce.kyushu-u.ac.jp/' asUrl
]

{ #category : #examples }
ViennaModel class >> exampleFibonacci [
	"ViennaModel exampleFibonacci"

	| vdmc |
	vdmc := ViennaModel on: 'http://vdmpad.csce.kyushu-u.ac.jp/' asUrl.
	vdmc
		specification:
			'
state State of
	n1 : nat
	n2 : nat
	init s == s = mk_State(0, 1)
end
operations
	next : () ==> nat
	next() == (dcl n : nat := n1 + n2; n1 := n2; n2 := n; return n);'.
	^ (Array streamContents: [ :stream | 10 timesRepeat: [ stream nextPut: (vdmc evaluate: 'next()') ] ]) inspect; yourself
]

{ #category : #'instance creation' }
ViennaModel class >> on: aUrlOfVDMPadServer [
	^ self new
		url: aUrlOfVDMPadServer;
		yourself
]

{ #category : #accessing }
ViennaModel >> at: aString [
	^ self
		at: aString
		ifAbsent: [ KeyNotFound signalFor: aString in: self ]
]

{ #category : #accessing }
ViennaModel >> at: aString ifAbsent: errorBlock [
	^ self at: aString ifPresent: [ :value | value ] ifAbsent: errorBlock
]

{ #category : #accessing }
ViennaModel >> at: aString ifAbsentPut: errorBlock [
	^ self
		at: aString
		ifPresent: [ :value | value ]
		ifAbsent: [ state at: aString put: (writer stringify: errorBlock value) ]
]

{ #category : #accessing }
ViennaModel >> at: aString ifPresent: errorBlock [
	^ self at: aString ifPresent: errorBlock ifAbsent: [  ]
]

{ #category : #accessing }
ViennaModel >> at: aString ifPresent: aBlock ifAbsent: errorBlock [
	^ state at: aString ifPresent: [ :value | aBlock cull: (reader parseOn: value readStream) ] ifAbsent: errorBlock
]

{ #category : #accessing }
ViennaModel >> at: aString put: anObject [
	^ state at: aString put: (writer stringify: anObject)
]

{ #category : #defaults }
ViennaModel >> defaultUrl [
	^ 'http://vdmpad.csce.kyushu-u.ac.jp/' asUrl
]

{ #category : #evaluating }
ViennaModel >> evaluate: aString [
	lock
		critical: [ 
			| json response postState |
			json := Dictionary new.
			state keysAndValuesDo: [ :key :value | json at: key put: value ].
			json at: 'source' put: self specification.
			json at: 'expression' put: aString.
			http entity: (ZnEntity with: (self stringify: json) type: ZnMimeType applicationJson).
			response := http post.
			json := self parseJson: response.
			(json at: 'message') ifNotEmpty: [ :msg | ^ Error signal: msg ].
			postState := Dictionary new.
			json
				keysAndValuesDo: [ :key :value | 
					(key includes: $`)
						ifTrue: [ postState at: key put: value ] ].
			state := postState.
			^ reader parseOn: (json at: 'value') readStream ]
]

{ #category : #evaluating }
ViennaModel >> init [
	lock
		critical: [ 
			| json response postState |
			json := Dictionary new.
			json at: 'source' put: self specification.
			json at: 'expression' put: ''.
			http entity: (ZnEntity with: (self stringify: json) type: ZnMimeType applicationJson).
			response := http post.
			json := self parseJson: response.
			(json at: 'message') ifNotEmpty: [ :msg | ^ Error signal: msg ].
			postState := Dictionary new.
			json
				keysAndValuesDo: [ :key :value | 
					(key includes: $`)
						ifTrue: [ postState at: key put: value ] ].
			state := postState]
]

{ #category : #'initialize-release' }
ViennaModel >> initialize [
	super initialize.
	lock := Semaphore forMutualExclusion.
	http := ZnClient new.
	self url: self defaultUrl.
	specification := String new.
	state := Dictionary new.
	reader := ViennaReader new.
	writer := ViennaWriter new
]

{ #category : #private }
ViennaModel >> parseJson: aJsonString [
	^ NeoJSONReader fromString: aJsonString
]

{ #category : #accessing }
ViennaModel >> reader [
	^ reader
]

{ #category : #accessing }
ViennaModel >> reader: aVDMCReader [
	reader := aVDMCReader
]

{ #category : #accessing }
ViennaModel >> specification [
	^ specification
]

{ #category : #accessing }
ViennaModel >> specification:aString [
	specification := aString
]

{ #category : #private }
ViennaModel >> stringify: aJsonObject [
	^ String streamContents: [ :stream |
			(NeoJSONWriter on: stream) asciiOnly: true; nextPut: aJsonObject ]

]

{ #category : #accessing }
ViennaModel >> url [
	^ http url directory
]

{ #category : #accessing }
ViennaModel >> url: aUrlOfVDMPadServer [
	http url: aUrlOfVDMPadServer asUrl / 'eval'
]

{ #category : #accessing }
ViennaModel >> writer [
	^ writer
]

{ #category : #accessing }
ViennaModel >> writer: aVDMCWriter [
	writer := aVDMCWriter
]
