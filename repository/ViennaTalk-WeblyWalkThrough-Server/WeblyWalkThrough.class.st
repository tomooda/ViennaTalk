Class {
	#name : #WeblyWalkThrough,
	#superclass : #VDMC,
	#traits : 'TWeblyWalkThrough',
	#classTraits : 'TWeblyWalkThrough classTrait',
	#instVars : [
		'vdmc',
		'translator'
	],
	#classVars : [
		'Current',
		'Server'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Server'
}

{ #category : #accessing }
WeblyWalkThrough class >> current [
	^ Current ifNil: [ Current := self default ]
]

{ #category : #defaults }
WeblyWalkThrough class >> defaultPort [
	^ 8087
]

{ #category : #servicing }
WeblyWalkThrough class >> flushServer [
	"WeblyWalkThrough flushServer"

	Server
		ifNotNil: [ 
			Server stop.
			Server unregister.
			Server := nil ]
]

{ #category : #servicing }
WeblyWalkThrough class >> installHandler [
	"WeblyWalkThrough installHandler"

	self server delegate: self current
]

{ #category : #testing }
WeblyWalkThrough class >> isPublished [
	^ self current isPublished
]

{ #category : #servicing }
WeblyWalkThrough class >> server [
	^ Server
		ifNil: [ 
			Server := (ZnMultiThreadedServer on: self defaultPort)
				register;
				yourself ]
]

{ #category : #servicing }
WeblyWalkThrough class >> startService [
	self installHandler.
	self server start
]

{ #category : #servicing }
WeblyWalkThrough class >> stopService [
	self server stop
]

{ #category : #'request handling' }
WeblyWalkThrough >> apiCall: apiName in: moduleName withArguments: args [
	| evalString result resultJson |
	evalString := moduleName ifNil: [ apiName ] ifNotNil: [ moduleName , '`' , apiName ].
	result := self
		plainEvaluate: evalString , '(' , (',' join: args) , ')'
		ifError: [ :msg | ^ self responseServerError: evalString , String cr , String cr , msg ].
	resultJson := self translateToJson: result.
	resultJson isPetitFailure
		ifTrue: [ ^ self responseServerError: resultJson printString , ' : ' , result asString ].
	^ self
		responseOk:
			((ZnStringEntity type: ZnMimeType applicationJson)
				string: resultJson;
				yourself)
]

{ #category : #'initialize-release' }
WeblyWalkThrough >> initialize [
	super initialize.
	translator := WWTTranslator new
]

{ #category : #testing }
WeblyWalkThrough >> isPublished [
	^ self class server isRunning and: [ self class server delegate == self ]
]

{ #category : #translating }
WeblyWalkThrough >> translateFromJson: aString [
	^ self translator jsonToVdmString: aString
]

{ #category : #translating }
WeblyWalkThrough >> translateToJson: aString [
	^ self translator vdmToJsonString: aString
]

{ #category : #accessing }
WeblyWalkThrough >> translator [
	^ translator
]

{ #category : #accessing }
WeblyWalkThrough >> translator: aWWTTranslator [
	translator := aWWTTranslator
]
