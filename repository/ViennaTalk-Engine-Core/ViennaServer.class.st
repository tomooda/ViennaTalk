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
	^ 8085
]

{ #category : #'instance creation' }
ViennaServer class >> new: anInteger [
	^ self basicNew initialize: anInteger
]

{ #category : #accessing }
ViennaServer class >> server [
	^ Server
		ifNil: [ 
			Server := (ZnMultiThreadedServer on: self defaultPort)
				register;
				start;
				yourself ]
]

{ #category : #servicing }
ViennaServer class >> startUpServer [
	"ViennaServer startUpServer"
	self server delegate map: 'eval' to: self new
]

{ #category : #defaults }
ViennaServer >> defaultNumberOfProcesses [
	^ 16
]

{ #category : #evaluating }
ViennaServer >> evaluate: expression specification: specification states: states vdm10: vdm10 rtc: rtc [
	^ engine
		evaluate: expression
		specification: specification
		states: states
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
			json inspect.
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

{ #category : #'initialize-release' }
ViennaServer >> initialize [
	self initialize: self defaultNumberOfProcesses 
]

{ #category : #'initialize-release' }
ViennaServer >> initialize: anInteger [
	super initialize.
	engine := VDMJProcess bank: anInteger
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
