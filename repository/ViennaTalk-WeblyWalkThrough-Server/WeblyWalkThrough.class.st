Class {
	#name : #WeblyWalkThrough,
	#superclass : #ViennaAnimation,
	#traits : 'TWeblyWalkThrough',
	#classTraits : 'TWeblyWalkThrough classTrait',
	#instVars : [
		'translator',
		'frontPage',
		'globalNamesAndNumArgs',
		'displayEnabled',
		'taggedElementDecoder',
		'displayModule',
		'displayOperation'
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

{ #category : #accessing }
WeblyWalkThrough >> disableDisplay [
	self displayEnabled: false
]

{ #category : #'request handling' }
WeblyWalkThrough >> display [
	| evalString result xml |
	evalString := displayModule  ifNil: [ displayOperation ] ifNotNil: [ displayModule , '`' , displayOperation ].
	result := self
		plainEvaluate: evalString , '()'
		ifError: [ :msg | ^ self responseServerError: 'display operation failed.' ].
	xml := self taggedElement2xml: result.
	^ self
		responseOk:
			((ZnStringEntity type: ZnMimeType imageSvg)
				string: xml;
				yourself)
]

{ #category : #accessing }
WeblyWalkThrough >> displayEnabled [
	^ displayEnabled
]

{ #category : #accessing }
WeblyWalkThrough >> displayEnabled: aBool [
	displayEnabled := aBool = true
]

{ #category : #accessing }
WeblyWalkThrough >> enableDisplay [
	self displayEnabled: true
]

{ #category : #'request handling' }
WeblyWalkThrough >> event: aDictionary [
	| module operation type target evalString |
	module := aDictionary at: 'module'.
	operation := aDictionary at: 'operation'.
	type := aDictionary at: 'type'.
	target := (aDictionary at: 'target') asInteger.
	evalString := String
		streamContents: [ :stream | 
			stream
				nextPutAll: module;
				nextPut: $`;
				nextPutAll: operation;
				nextPutAll: '(mk_ViennaDOM`'.
			type = 'click'
				ifTrue: [ stream
						nextPutAll: 'MouseEvent(<';
						nextPutAll: type;
						nextPutAll: '>,';
						nextPutAll: target viennaString;
						nextPutAll: ',';
						nextPutAll: (aDictionary at: 'x') viennaString;
						nextPutAll: ',';
						nextPutAll: (aDictionary at: 'y') viennaString;
						nextPutAll: '))' ].
			type = 'change'
				ifTrue: [ stream
						nextPutAll: 'ChangeEvent(<';
						nextPutAll: type;
						nextPutAll: '>,';
						nextPutAll: target viennaString;
						nextPutAll: ',';
						nextPutAll: (aDictionary at: 'value') viennaString;
						nextPutAll: '))' ] ].
	self
		plainEvaluate: evalString
		in: module
		ifError: [ :msg | 
			^ self
				responseServerError: 'event operation ' , module , '`' , operation , ' failed.' ].
	^ self
		responseOk:
			((ZnStringEntity type: ZnMimeType textPlain)
				string: '';
				yourself)
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
	translator := WWTTranslator new.
	displayEnabled := true.
	displayModule := 'Counter'.
	displayOperation := 'display'
]

{ #category : #testing }
WeblyWalkThrough >> isPublished [
	^ self class server isRunning and: [ self class server delegate == self ]
]

{ #category : #javascript }
WeblyWalkThrough >> printDisplayFunctionsOn: aStream [
	aStream nextPutAll: 'Webly.display = function () {'.
	self displayEnabled
		ifTrue: [ aStream
				nextPutAll:
					'
    var req = new XMLHttpRequest();
    req.open("GET", "/display");
    req.onload = function () {while (Webly.displayElement.firstChild) Webly.displayElement.removeChild(Webly.displayElement.firstChild); Webly.displayElement.appendChild(req.responseXML.documentElement.childNodes[0]);};
    req.send();
' withUnixLineEndings ].
	aStream
		nextPutAll: '};';
		lf.
	self displayEnabled
		ifTrue: [ aStream
				nextPutAll:
					'window.onload = function () {Webly.displayElement = document.getElementById("display");Webly.display();};';
				lf ]
]

{ #category : #javascript }
WeblyWalkThrough >> printDynamicWeblyFunctionsOn: aStream [
	(globalNamesAndNumArgs collect: #first) asSet asSortedCollection
		do: [ :mod | 
			aStream
				nextPutAll: 'Webly.';
				nextPutAll: mod;
				nextPutAll: ' = {};';
				lf ].
	globalNamesAndNumArgs
		do: [ :triple | 
			aStream
				nextPutAll: 'Webly.';
				nextPutAll: triple first;
				nextPut: $.;
				nextPutAll: triple second;
				nextPutAll: ' = function('.
			(1 to: triple third)
				do: [ :i | 
					aStream
						nextPut: $a;
						nextPutAll: i asString;
						nextPutAll: ', ' ].
			aStream
				nextPutAll: 'cont) {';
				nextPutAll: 'Webly.call("';
				nextPutAll: triple first;
				nextPutAll: '", "';
				nextPutAll: triple second;
				nextPutAll: '", ['.
			(1 to: triple third)
				do: [ :i | 
					aStream
						nextPut: $a;
						nextPutAll: i asString ]
				separatedBy: [ aStream nextPutAll: ', ' ].
			aStream
				nextPutAll: '], cont)};';
				lf ]
]

{ #category : #javascript }
WeblyWalkThrough >> printEventFunctionsOn: aStream [
	self displayEnabled
		ifTrue: [ aStream
				nextPutAll:
					'
Webly.event = function(event, module, operation, continuation) { 
    var req = new XMLHttpRequest();
    var arguments = {};
    arguments.module = module;
    arguments.operation = operation;
    arguments.type = event.type;
    arguments.target = event.target.getAttribute("identifier");
    if (event.type == "click") { 
        arguments.x = event.x;
        arguments.y = event.y;
    }
    if (event.type = "change") { 
        arguments.value = event.target.value;
    }
    req.open("POST", "/event");
    req.setRequestHeader("Content-Type", "application/json");
    req.onload = function () {Webly.display(); if (continuation) continuation();};
    req.send(JSON.stringify(arguments));
};
' withUnixLineEndings ]
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
WeblyWalkThrough >> taggedElement2xml: aString [
	| element |
	element := self taggedElementDecoder parse: aString.
	^ String
		streamContents: [ :stream | 
			stream
				nextPutAll:
					'<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">'.
			element isPetit2Failure
				ifTrue: [ aString ]
				ifFalse: [ element isString
						ifTrue: [ stream
								nextPutAll:
									'<text x="0" y="12" font-family="Helvetica" font-size="12" color="black">';
								nextPutAll: element;
								nextPutAll: '</text>' ]
						ifFalse: [ element printXmlOn: stream ] ].
			stream nextPutAll: '</svg>' ]
]

{ #category : #accessing }
WeblyWalkThrough >> taggedElementDecoder [
	^ taggedElementDecoder
		ifNil: [ taggedElementDecoder := ViennaVDMTaggedElementDecoder new ]
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
	^ String
		streamContents: [ :stream | 
			stream
				nextPutAll:
					'Webly = {};
Webly.call = function(module, operation, arguments, continuation) { 
    var req = new XMLHttpRequest();
    req.open("POST", "/"+module+"/"+operation);
    req.setRequestHeader("Content-Type", "application/json");
    req.onload = function () {Webly.display(); if (continuation) continuation(JSON.parse(this.responseText));};
    req.send(JSON.stringify(arguments));
};
' withUnixLineEndings.
			self
				printDynamicWeblyFunctionsOn: stream;
				printDisplayFunctionsOn: stream;
				printEventFunctionsOn: stream ]
]
