Class {
	#name : #ViennaClient,
	#superclass : #ViennaEngine,
	#instVars : [
		'http'
	],
	#category : 'ViennaTalk-Engine-Core'
}

{ #category : #defaults }
ViennaClient class >> defaultUrl [
	^ 'http://vdmpad.csce.kyushu-u.ac.jp/' asUrl
]

{ #category : #examples }
ViennaClient class >> exampleFibonacci [
	"ViennaModel exampleFibonacci"

	| vienna |
	vienna := ViennaClient on: 'http://vdmpad.csce.kyushu-u.ac.jp/' asUrl.
	vienna
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
	^ (Array streamContents: [ :stream | 10 timesRepeat: [ stream nextPut: (vienna evaluate: 'next()') ] ]) inspect; yourself
]

{ #category : #'instance creation' }
ViennaClient class >> on: aUrlOfVDMPadServer [
	^ self new
		url: aUrlOfVDMPadServer;
		yourself
]

{ #category : #evaluating }
ViennaClient >> evaluate: expression specification: specification states: states vdm10: vdm10 rtc: rtc [
	| json response |
	json := Dictionary new.
	states
		keysAndValuesDo: [ :module :binds | binds keysAndValuesDo: [ :var :value | json at: module , '`' , var put: value ] ].
	json at: 'source' put: specification.
	json at: 'expression' put: expression.
	vdm10 = false
		ifTrue: [ json at: 'classic' put: String new ].
	rtc = false
		ifTrue: [ json at: 'ignoreRuntimeChecking' put: String new ].
	http entity: (ZnEntity with: (self stringify: json) type: ZnMimeType applicationJson).
	response := http post.
	json := self parseJson: response.
	^ Array
		with: ((json at: 'message') ifEmpty: [ json at: 'value' ] ifNotEmpty: [ nil ])
		with: (self stateFromJson: json)
		with: (json at: 'message')
]

{ #category : #'initialize-release' }
ViennaClient >> initialize [
	super initialize.
	http := ZnClient new.
]

{ #category : #private }
ViennaClient >> parseJson: aJsonString [
	^ NeoJSONReader fromString: aJsonString
]

{ #category : #private }
ViennaClient >> stateFromJson: aDictionary [
	| states |
	states := Dictionary new.
	aDictionary
		keysAndValuesDo: [ :key :value | 
			(key includes: $`)
				ifTrue: [ 
					| index module var |
					index := key indexOf: $`.
					module := key copyFrom: 1 to: index - 1.
					var := key copyFrom: index + 1 to: key size.
					(states at: module ifAbsentPut: [ Dictionary new ]) at: var put: value ] ].
	^ states
]

{ #category : #private }
ViennaClient >> stringify: aJsonObject [
	^ String streamContents: [ :stream |
			(NeoJSONWriter on: stream) asciiOnly: true; nextPut: aJsonObject ]

]

{ #category : #accessing }
ViennaClient >> url [
	^ http url directory
]

{ #category : #accessing }
ViennaClient >> url: aUrlOfVDMPadServer [
	http url: aUrlOfVDMPadServer asUrl / 'eval'
]
