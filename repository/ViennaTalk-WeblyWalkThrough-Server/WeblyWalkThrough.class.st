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
	^ Current ifNil: [ Current := self new ]
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

{ #category : #servicing }
WeblyWalkThrough class >> server [
	^ Server
		ifNil: [ 
			Server := (ZnMultiThreadedServer on: self defaultPort)
				register;
				start;
				yourself ]
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
		ifTrue: [ args := aZnRequest uri query values collect: [ :arg | translator jsonToVdm: arg ] ].
	method = 'post'
		ifTrue: [ 
			(aZnRequest contentType main = 'application' and: [ aZnRequest contentType sub asLowercase = 'json' ])
				ifTrue: [ args := Array with: (translator jsonToVdm: aZnRequest entity) ].
			(aZnRequest contentType main = 'application'
				and: [ aZnRequest contentType sub asLowercase = 'x-www-form-urlencoded' ])
				ifTrue: [ args := aZnRequest entity fields values collect: [ :arg | translator jsonToVdm: arg ] ] ].
	evalString := ('`' join: path) , '(' , (', ' join: args) , ')'.
	result := self
		plainEvaluate: evalString
		ifError: [ :msg | ^ ZnResponse serverError: evalString , String cr , String cr , msg ].
	resultJson := translator vdmToJson: result.
	resultJson isPetitFailure
		ifTrue: [ self halt ].
	^ ZnResponse ok: (ZnEntity json: resultJson)
]

{ #category : #'initialize-release' }
WeblyWalkThrough >> initialize [
	super initialize.
	translator := WWTTranslator new
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
