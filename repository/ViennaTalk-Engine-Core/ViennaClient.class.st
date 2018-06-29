Class {
	#name : #ViennaClient,
	#superclass : #ViennaEngine,
	#instVars : [
		'http'
	],
	#category : 'ViennaTalk-Engine-Core'
}

{ #category : #'instance creation' }
ViennaClient class >> default [
	^ self on: self defaultUrl
]

{ #category : #defaults }
ViennaClient class >> defaultUrl [
	^ 'http://vdmpad.csce.kyushu-u.ac.jp/' asUrl
]

{ #category : #'instance creation' }
ViennaClient class >> localhost [
	"ViennaClient localhost evaluate: '1+2' specification: '' states: Dictionary new"

	^ self on: 'http://localhost:8088/'
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
