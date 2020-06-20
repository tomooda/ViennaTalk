Class {
	#name : #WeblyWalkThrough,
	#superclass : #ViennaAnimation,
	#traits : 'TWeblyWalkThrough',
	#classTraits : 'TWeblyWalkThrough classTrait',
	#instVars : [
		'translator',
		'frontPage',
		'globalNamesAndNumArgs'
	],
	#classVars : [
		'Current',
		'Server'
	],
	#category : #'ViennaTalk-WeblyWalkThrough-Server'
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
	resultJson isPetit2Failure
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

{ #category : #converting }
WeblyWalkThrough >> copyForTest [
	| animation |
	animation := ViennaAnimation default.
	animation
		specification: specification
		ifError: [ :msg | self error: msg ].
	^ animation
]

{ #category : #defaults }
WeblyWalkThrough >> defaultFrontPage [
	^ '<!DOCTYPE html>
<html>
<head><meta charset="UTF-8">
<title>Webly Walk-Through</title>
</head>
<body>
Webly Walk-Through is running.
</body></html>' copy
]

{ #category : #javascript }
WeblyWalkThrough >> dynamicWeblyFunctions [
	^ String
		streamContents: [ :stream | 
			stream lf.
			(globalNamesAndNumArgs collect: #first) asSet asSortedCollection
				do: [ :mod | 
					stream
						nextPutAll: 'Webly.';
						nextPutAll: mod;
						nextPutAll: ' = {};';
						lf ].
			globalNamesAndNumArgs
				do: [ :triple | 
					stream
						nextPutAll: 'Webly.';
						nextPutAll: triple first;
						nextPut: $.;
						nextPutAll: triple second;
						nextPutAll: ' = function('.
					(1 to: triple third)
						do: [ :i | 
							stream
								nextPut: $a;
								nextPutAll: i asString;
								nextPutAll: ', ' ].
					stream
						nextPutAll: 'cont) {';
						nextPutAll: 'Webly.call("';
						nextPutAll: triple first;
						nextPutAll: '", "';
						nextPutAll: triple second;
						nextPutAll: '", ['.
					(1 to: triple third)
						do: [ :i | 
							stream
								nextPut: $a;
								nextPutAll: i asString ]
						separatedBy: [ stream nextPutAll: ', ' ].
					stream
						nextPutAll: '], cont)};';
						lf ] ]
]

{ #category : #accessing }
WeblyWalkThrough >> frontPage [
	^ frontPage
		ifNil: [ frontPage := self defaultFrontPage]
]

{ #category : #accessing }
WeblyWalkThrough >> frontPage: aString [
	frontPage := aString asString
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
WeblyWalkThrough >> specification: aString [
	self updateGlobalNamesAndNumArgs: aString.
	super specification: aString
]

{ #category : #accessing }
WeblyWalkThrough >> specification: aString ifError: aBlock [
	self updateGlobalNamesAndNumArgs: aString.
	super specification: aString ifError: [ :msg | ^ aBlock value: msg ]
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

{ #category : #accessing }
WeblyWalkThrough >> updateGlobalNamesAndNumArgs: aString [
	| ast |
	ast := ViennaVDMParser new parse: aString.
	(ast isPetit2Failure or: [ ast isEmpty ])
		ifTrue: [ globalNamesAndNumArgs := #().
			^ self ].
	globalNamesAndNumArgs := Array
		streamContents: [ :stream | 
			(ast first label = 'Module'
				ifTrue: [ ast ]
				ifFalse: [ {ast} ])
				do: [ :mod | 
					| modName |
					modName := mod label = 'Module'
						ifTrue: [ mod first ]
						ifFalse: [ self defaultModule ].
					mod
						allDescendantsDo: [ :node | 
							node label = 'ExplicitFunctionDefinition'
								ifTrue: [ stream
										nextPut:
											{modName.
											node first.
											node fifth first size} ].
							node label = 'ExplicitOperationDefinition'
								ifTrue: [ stream
										nextPut:
											{modName.
											node first.
											node fourth size} ] ] ] ]
]

{ #category : #javascript }
WeblyWalkThrough >> webly_js [
	^ ('
Webly = {};
Webly.call = function(module, operation, arguments, continuation) { 
    var req = new XMLHttpRequest();
    req.open("POST", "/"+module+"/"+operation);
    req.setRequestHeader("Content-Type", "application/json");
    req.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200)
            continuation(JSON.parse(this.responseText));
    };
    req.send(JSON.stringify(arguments));
};
' trim copyReplaceAll: String cr with: String lf), self dynamicWeblyFunctions
]
