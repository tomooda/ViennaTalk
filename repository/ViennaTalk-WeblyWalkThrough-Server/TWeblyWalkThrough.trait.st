Trait {
	#name : #TWeblyWalkThrough,
	#category : 'ViennaTalk-WeblyWalkThrough-Server'
}

{ #category : #'request handling' }
TWeblyWalkThrough >> apiCall: apiName in: moduleName withArguments: args [
	^ self subclassResponsibility
]

{ #category : #'request handling' }
TWeblyWalkThrough >> argsFrom: aZnRequest [
	| args |
	args := Array new.
	aZnRequest method asLowercase = 'get'
		ifTrue: [ 
			args := aZnRequest uri query
				ifNil: [ #() ]
				ifNotNil: [ :query | query values collect: [ :arg | self translateFromJson: arg ] ] ].
	aZnRequest method asLowercase = 'post'
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

{ #category : #'request handling' }
TWeblyWalkThrough >> frontPage [
	^ self
		responseOk:
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
TWeblyWalkThrough >> handleApi: aZnRequest [
	| args path |
	args := self argsFrom: aZnRequest.
	path := aZnRequest uri segments.
	path size = 1
		ifTrue: [ ^ self apiCall: path first in: nil withArguments: args ].
	path size = 2
		ifTrue: [ ^ self apiCall: path second in: path first withArguments: args ].
	^ self responseNotFound: aZnRequest uri
]

{ #category : #'request handling' }
TWeblyWalkThrough >> handleRequest: aZnRequest [
	| path method |
	path := aZnRequest uri isSlash
		ifTrue: [ ^ self frontPage ]
		ifFalse: [ aZnRequest uri segments ].
	path size > 2
		ifTrue: [ ^ self responseNotFound: aZnRequest url ].
	path = #('favicon.ico')
		ifTrue: [ ^ self responseNotFound: aZnRequest url ].
	method := aZnRequest method asLowercase.
	method = 'options'
		ifTrue: [ 
			^ self
				responseOk:
					((ZnStringEntity type: ZnMimeType textPlain)
						string: '';
						yourself) ].
	^ self handleApi: aZnRequest
]

{ #category : #responses }
TWeblyWalkThrough >> responseNotFound: aString [
	| response |
	response := ZnResponse notFound: aString.
	response headers
		at: 'Access-Control-Allow-Origin' put: '*';
		at: 'Access-Control-Allow-Headers' put: 'Content-Type';
		at: 'Access-Control-Allow-Content-Type' put: ZnMimeType applicationJson printString.
	^ response
]

{ #category : #responses }
TWeblyWalkThrough >> responseOk: anZnEntity [
	| response |
	response := ZnResponse ok: anZnEntity.
	response headers
		at: 'Access-Control-Allow-Origin' put: '*';
		at: 'Access-Control-Allow-Headers' put: 'Content-Type';
		at: 'Access-Control-Allow-Content-Type' put: ZnMimeType applicationJson printString.
	^ response
]

{ #category : #responses }
TWeblyWalkThrough >> responseServerError: aStrng [
	| response |
	response := ZnResponse serverError: aStrng.
	response headers
		at: 'Access-Control-Allow-Origin' put: '*';
		at: 'Access-Control-Allow-Headers' put: 'Content-Type';
		at: 'Access-Control-Allow-Content-Type' put: ZnMimeType applicationJson printString.
	^ response
]

{ #category : #translating }
TWeblyWalkThrough >> translateFromJson: aString [
	^ self subclassResponsibility
]

{ #category : #translating }
TWeblyWalkThrough >> translateToJson: aString [
	^ self subclassResponsibility
]

{ #category : #'request handling' }
TWeblyWalkThrough >> value: aZnRequest [
	^ self handleRequest: aZnRequest
]
