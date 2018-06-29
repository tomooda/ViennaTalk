Class {
	#name : #ViennaServer,
	#superclass : #ViennaEngine,
	#instVars : [
		'engine'
	],
	#classVars : [
		'Server'
	],
	#category : 'ViennaTalk-Engine-Core'
}

{ #category : #defaults }
ViennaServer class >> defaultPort [
	^ 8088
]

{ #category : #servicing }
ViennaServer class >> ensureServeIn: aBlock [
	| isRunning |
	isRunning := self isRunning.
	isRunning
		ifFalse: [ self installHandler ].
	aBlock
		ensure: [ 
			isRunning
				ifFalse: [ self flushServer ] ]
]

{ #category : #servicing }
ViennaServer class >> flushServer [
	"ViennaServer flushServer"

	Server
		ifNotNil: [ 
			Server stop.
			Server unregister.
			Server := nil ]
]

{ #category : #servicing }
ViennaServer class >> installHandler [
	"ViennaServer installHandler"

	self server delegate map: 'eval' to: self new
]

{ #category : #testing }
ViennaServer class >> isRunning [
	^ Server notNil and: [ Server isRunning ]
]

{ #category : #'instance creation' }
ViennaServer class >> new: anInteger [
	^ self on: (ViennaVDMJ bank: anInteger)
]

{ #category : #'instance creation' }
ViennaServer class >> on: aViennaEngine [
	^ self new
		engine: aViennaEngine;
		yourself
]

{ #category : #servicing }
ViennaServer class >> server [
	^ Server
		ifNil: [ 
			Server := (ZnMultiThreadedServer on: self defaultPort)
				register;
				start;
				yourself ]
]

{ #category : #defaults }
ViennaServer >> defaultEngine [
	^ ViennaVDMJ bank: 16
]

{ #category : #accessing }
ViennaServer >> engine [
	^ engine ifNil: [ engine := self defaultEngine ]
]

{ #category : #accessing }
ViennaServer >> engine: aViennaEngine [
	engine := aViennaEngine
]

{ #category : #evaluating }
ViennaServer >> evaluate: expression specification: specification states: states module: module vdm10: vdm10 rtc: rtc [
	^ self engine
		evaluate: expression
		specification: specification
		states: states
		module: module
		vdm10: vdm10
		rtc: rtc
]

{ #category : #'request handling' }
ViennaServer >> handleRequest: aZnRequest [
	| json |
	aZnRequest entity
		ifNotNil: [ :jsonString | 
			| source expression preStates result |
			json := NeoJSONReader fromString: jsonString.
			source := json at: 'source' ifAbsent: [ String new ].
			expression := json at: 'expression' ifAbsent: [ String new ].
			preStates := Dictionary new: json size.
			json
				keysAndValuesDo: [ :key :value | 
					(key includes: $`)
						ifTrue: [ 
							| index module var |
							index := key indexOf: $`.
							module := key copyFrom: 1 to: index - 1.
							var := key copyFrom: index + 1 to: key size.
							(preStates at: module ifAbsentPut: [ Dictionary new ]) at: var put: value ] ].
			result := self
				evaluate: expression
				specification: source
				states: preStates
				vdm10: (json includesKey: 'classic') not
				rtc: (json includesKey: 'ignoreRuntimeChecking') not.
			json := Dictionary new.
			json
				at: 'source' put: source;
				at: 'expression' put: expression;
				at: 'value' put: (result first ifNil: [ String new ]);
				at: 'message' put: result third.
			result second
				keysAndValuesDo: [ :moduleName :bindings | bindings keysAndValuesDo: [ :varName :value | json at: moduleName , '`' , varName put: value ] ].
			^ ZnResponse ok: (ZnEntity with: (self stringify: json) type: ZnMimeType applicationJson) ].
	^ ZnResponse notFound: aZnRequest url
]

{ #category : #private }
ViennaServer >> stringify: aJsonObject [
	^ String
		streamContents: [ :stream | 
			(NeoJSONWriter on: stream)
				asciiOnly: true;
				nextPut: aJsonObject ]
]

{ #category : #'request handling' }
ViennaServer >> value: aZnRequest [
	^ self handleRequest: aZnRequest
]
