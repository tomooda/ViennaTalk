Class {
	#name : #WeblyWalkThrough,
	#superclass : #VDMC,
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
WeblyWalkThrough >> frontPage [
	^ ZnResponse
		ok:
			(ZnStringEntity
				html:
					'<!DOCTYPE html>
<html>
<head><meta charset="UTF-8">
<title>Webly Walk-Through</title>
</head>
<body>
Webly Walk-Through is running.
</body></html>')
]

{ #category : #'request handling' }
WeblyWalkThrough >> handleRequest: aZnRequest [
	| path method args result evalString resultJson |
	path := aZnRequest uri isSlash
		ifTrue: [ ^ self frontPage ]
		ifFalse: [ aZnRequest uri segments ].
	path size > 2
		ifTrue: [ ^ ZnResponse notFound: aZnRequest url ].
	path = #('favicon.ico')
		ifTrue: [ ^ ZnResponse notFount: aZnRequest url ].
	args := Array new.
	method := aZnRequest method asLowercase.
	method = 'get'
		ifTrue: [ 
			args := aZnRequest uri query
				ifNil: [ #() ]
				ifNotNil: [ :query | query values collect: [ :arg | translator jsonToVdmString: arg ] ] ].
	method = 'post'
		ifTrue: [ 
			(aZnRequest contentType main = 'application' and: [ aZnRequest contentType sub asLowercase = 'json' ])
				ifTrue: [ args := Array with: (translator jsonToVdmString: aZnRequest entity) ].
			(aZnRequest contentType main = 'application'
				and: [ aZnRequest contentType sub asLowercase = 'x-www-form-urlencoded' ])
				ifTrue: [ args := aZnRequest entity fields values collect: [ :arg | translator jsonToVdmString: arg ] ] ].
	evalString := ('`' join: path) , '(' , (', ' join: args) , ')'.
	result := self
		plainEvaluate: evalString
		ifError: [ :msg | ^ ZnResponse serverError: evalString , String cr , String cr , msg ].
	resultJson := translator vdmToJsonString: result.
	resultJson isPetitFailure
		ifTrue: [ ^ ZnResponse serverError: resultJson printString , ' : ' , result asString ].
	^ ZnResponse
		ok:
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

{ #category : #accessing }
WeblyWalkThrough >> translator [
	^ translator
]

{ #category : #accessing }
WeblyWalkThrough >> translator: aWWTTranslator [
	translator := aWWTTranslator
]

{ #category : #'request handling' }
WeblyWalkThrough >> value: aZnRequest [
	^ self handleRequest: aZnRequest
]