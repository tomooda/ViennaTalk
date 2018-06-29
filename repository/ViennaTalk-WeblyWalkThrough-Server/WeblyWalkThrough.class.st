Class {
	#name : #WeblyWalkThrough,
	#superclass : #ViennaAnimation,
	#traits : 'TWeblyWalkThrough',
	#classTraits : 'TWeblyWalkThrough classTrait',
	#instVars : [
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

{ #category : #'request handling' }
WeblyWalkThrough >> argsFrom: aZnRequest [
	| args |
	args := Array new.
	aZnRequest method asLowercase = 'get'
		ifTrue: [ 
			args := aZnRequest uri query
				ifNil: [ #() ]
				ifNotNil: [ :query | query values collect: [ :arg | self translateFromJson: arg ] ] ].
	aZnRequest method asLowercase= 'post'
		ifTrue: [ 
			(aZnRequest contentType main = 'application' and: [ aZnRequest contentType sub asLowercase = 'json' ])
				ifTrue: [ 
					args := NeoJSONReader fromString: aZnRequest entity contents.
					args isArray
						ifTrue: [ args := args collect: [ :arg | self translateFromJson: (NeoJSONWriter toString: arg) ] ]
						ifFalse: [ args := self translateFromJson: aZnRequest entity contents ] ]
				ifFalse: [ 
					(aZnRequest contentType main = 'application' and: [ aZnRequest contentType sub asLowercase = 'x-www-form-urlencoded' ])
						ifTrue: [ args := aZnRequest entity fields values collect: [ :arg | self translateFromJson: arg ] ] ] ].
	^ args
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
