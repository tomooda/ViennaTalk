Class {
	#name : 'WeblyWalkThrough',
	#superclass : 'Model',
	#instVars : [
		'animation',
		'translator',
		'frontPage',
		'globalNamesAndNumArgs',
		'displayEnabled',
		'taggedElementDecoder',
		'displayOperation',
		'handleEventOperation',
		'guiModule'
	],
	#classVars : [
		'Current',
		'Server'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Server',
	#package : 'ViennaTalk-WeblyWalkThrough-Server'
}

{ #category : 'accessing' }
WeblyWalkThrough class >> current [

	^ Current ifNil: [ Current := self new ]
]

{ #category : 'defaults' }
WeblyWalkThrough class >> defaultPort [
	^ 8087
]

{ #category : 'servicing' }
WeblyWalkThrough class >> flushServer [
	"WeblyWalkThrough flushServer"

	Server
		ifNotNil: [ 
			Server stop.
			Server unregister.
			Server := nil ]
]

{ #category : 'servicing' }
WeblyWalkThrough class >> installHandler [
	"WeblyWalkThrough installHandler"

	self server delegate: self current
]

{ #category : 'testing' }
WeblyWalkThrough class >> isPublished [
	^ self current isPublished
]

{ #category : 'servicing' }
WeblyWalkThrough class >> server [
	^ Server
		ifNil: [ 
			Server := (ZnMultiThreadedServer on: self defaultPort)
				register;
				yourself ]
]

{ #category : 'servicing' }
WeblyWalkThrough class >> startService [
	self installHandler.
	self server start
]

{ #category : 'servicing' }
WeblyWalkThrough class >> stopService [
	self server stop
]

{ #category : 'request handling' }
WeblyWalkThrough >> apiCall: apiName in: moduleName withArguments: args [

	| evalString result resultJson |
	evalString := moduleName
		              ifNil: [ apiName ]
		              ifNotNil: [ moduleName , '`' , apiName ].
	result := animation
		          plainEvaluate: evalString , '(' , (',' join: args) , ')'
		          ifError: [ :msg |
			          ^ self responseServerError:
				            evalString , String cr , String cr , msg ].
	resultJson := self translateToJson: result.
	resultJson isPetit2Failure ifTrue: [
			^ self responseServerError:
				  resultJson printString , ' : ' , result asString ].
	^ self responseOk:
		  ((ZnStringEntity type: ZnMimeType applicationJson)
			   string: resultJson;
			   yourself)
]

{ #category : 'request handling' }
WeblyWalkThrough >> argsFrom: aZnRequest [

	| args |
	args := Array new.
	aZnRequest method asLowercase = 'get' ifTrue: [
			args := aZnRequest uri query ifNil: [ #(  ) ] ifNotNil: [ :query |
				        query values collect: [ :arg |
					        self translateFromJson: arg ] ] ].
	aZnRequest method asLowercase = 'post' ifTrue: [
			(aZnRequest contentType main = 'application' and: [
				 aZnRequest contentType sub asLowercase = 'json' ])
				ifTrue: [
						args := NeoJSONReader fromString: aZnRequest entity contents.
						args isArray
							ifTrue: [
									args := args collect: [ :arg |
										        self translateFromJson:
											        (NeoJSONWriter toString: arg) ] ]
							ifFalse: [
							args := self translateFromJson: aZnRequest entity contents ] ]
				ifFalse: [
						(aZnRequest contentType main = 'application' and: [
							 aZnRequest contentType sub asLowercase
							 = 'x-www-form-urlencoded' ]) ifTrue: [
								args := aZnRequest entity fields values collect: [ :arg |
									        self translateFromJson: arg ] ] ] ].
	^ args
]

{ #category : 'evaluating' }
WeblyWalkThrough >> at: aString [

	^ animation at: aString
]

{ #category : 'evaluating' }
WeblyWalkThrough >> at: aString ifAbsent: aBlock [

	^ animation at: aString ifAbsent: aBlock
]

{ #category : 'evaluating' }
WeblyWalkThrough >> at: aString ifAbsentPut: aBlock [

	^ animation at: aString ifAbsentPut: aBlock
]

{ #category : 'evaluating' }
WeblyWalkThrough >> at: aString ifPresent: aBlock [

	^ animation at: aString ifPresent: aBlock
]

{ #category : 'evaluating' }
WeblyWalkThrough >> at: aString ifPresent: aBlock ifAbsent: anotherBlock [

	^ animation at: aString ifPresent: aBlock ifAbsent: anotherBlock
]

{ #category : 'evaluating' }
WeblyWalkThrough >> at: aString put: anotherString [

	^ animation at: aString put: anotherString
]

{ #category : 'evaluating' }
WeblyWalkThrough >> basicPlainEvaluate: aString in: moduleName ifError: errorBlock [

	^ animation
		  basicPlainEvaluate: aString
		  in: moduleName
		  ifError: errorBlock
]

{ #category : 'evaluating' }
WeblyWalkThrough >> becomeInterpretedAnimation [

	animation := animation becomeInterpretedAnimation
]

{ #category : 'evaluating' }
WeblyWalkThrough >> becomeTranspiledAnimation [

	animation := animation becomeTranspiledAnimation
]

{ #category : 'converting' }
WeblyWalkThrough >> copyForTest [

	^ animation copyForTest
]

{ #category : 'defaults' }
WeblyWalkThrough >> defaultDisplayOperation [

	^ 'display'
]

{ #category : 'defaults' }
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

{ #category : 'defaults' }
WeblyWalkThrough >> defaultGuiModule [

	^ ''
]

{ #category : 'defaults' }
WeblyWalkThrough >> defaultHandleEventOperation [

	^ 'handleEvent'
]

{ #category : 'evaluating' }
WeblyWalkThrough >> defaultModule [

	^ animation defaultModule
]

{ #category : 'accessing' }
WeblyWalkThrough >> disableDisplay [

	self displayEnabled: false
]

{ #category : 'request handling' }
WeblyWalkThrough >> display [

	| result xml |
	result := animation
		          plainEvaluate: self displayExpression
		          ifError: [ :msg |
		          ^ self responseServerError: 'display operation failed.' ].
	xml := self taggedElement2xml: result.
	^ self responseOk: ((ZnStringEntity type: ZnMimeType imageSvg)
			   string: xml;
			   yourself)
]

{ #category : 'accessing' }
WeblyWalkThrough >> displayEnabled [

	^ displayEnabled
]

{ #category : 'accessing' }
WeblyWalkThrough >> displayEnabled: aBool [

	displayEnabled := aBool = true
]

{ #category : 'accessing' }
WeblyWalkThrough >> displayExpression [

	^ String streamContents: [ :stream |
			  stream nextPutAll: 'ViennaDOM`setDocument('.
			  (guiModule notNil and: [ guiModule notEmpty ]) ifTrue: [
					  stream
						  nextPutAll: guiModule;
						  nextPut: $` ].
			  stream
				  nextPutAll: displayOperation;
				  nextPutAll: '())' ]
]

{ #category : 'accessing' }
WeblyWalkThrough >> displayOperation [

	^ displayOperation ifNil: [ self defaultDisplayOperation ]
]

{ #category : 'accessing' }
WeblyWalkThrough >> displayOperation: aString [

	displayOperation := aString trim
]

{ #category : 'accessing' }
WeblyWalkThrough >> enableDisplay [

	self displayEnabled: true
]

{ #category : 'evaluating' }
WeblyWalkThrough >> evaluate: aString [

	^ animation evaluate: aString
]

{ #category : 'request handling' }
WeblyWalkThrough >> event: aDictionary [

	| module operation type target evalString |
	module := self guiModule.
	operation := self handleEventOperation.
	type := aDictionary at: 'type'.
	target := aDictionary at: 'target'.
	evalString := String streamContents: [ :stream |
			              stream
				              nextPutAll: module;
				              nextPut: $`;
				              nextPutAll: operation;
				              nextPutAll: '(mk_ViennaDOM`'.
			              type = 'click' ifTrue: [
					              stream
						              nextPutAll: 'MouseEvent(<';
						              nextPutAll: type;
						              nextPutAll: '>, getElement(';
						              nextPutAll: target;
						              nextPutAll: '),';
						              nextPutAll: (aDictionary at: 'x') viennaString;
						              nextPutAll: ',';
						              nextPutAll: (aDictionary at: 'y') viennaString;
						              nextPutAll: '))' ].
			              type = 'change' ifTrue: [
					              stream
						              nextPutAll: 'ChangeEvent(<';
						              nextPutAll: type;
						              nextPutAll: '>, ViennaDOM`getElement(';
						              nextPutAll: target;
						              nextPutAll: '),';
						              nextPutAll: (aDictionary at: 'value') viennaString;
						              nextPutAll: '))' ] ].
	animation plainEvaluate: evalString in: module ifError: [ :msg |
			^ self responseServerError:
				  'event operation ' , module , '`' , operation , ' failed.' ].
	^ self display
]

{ #category : 'accessing' }
WeblyWalkThrough >> frontPage [

	^ self displayEnabled
		  ifTrue: [ self viennaVisualsPage ]
		  ifFalse: [
		  frontPage ifNil: [ frontPage := self defaultFrontPage ] ]
]

{ #category : 'accessing' }
WeblyWalkThrough >> frontPage: aString [

	frontPage := aString asString
]

{ #category : 'accessing' }
WeblyWalkThrough >> guiModule [

	^ guiModule
]

{ #category : 'accessing' }
WeblyWalkThrough >> guiModule: aString [

	guiModule := aString trim
]

{ #category : 'request handling' }
WeblyWalkThrough >> handleApi: aZnRequest [

	| args path |
	args := self argsFrom: aZnRequest.
	path := aZnRequest uri segments.
	path size = 1 ifTrue: [
		^ self apiCall: path first in: nil withArguments: args ].
	path size = 2 ifTrue: [
		^ self apiCall: path second in: path first withArguments: args ].
	^ self responseNotFound: aZnRequest uri
]

{ #category : 'accessing' }
WeblyWalkThrough >> handleEventOperation [

	^ handleEventOperation ifNil: [ self defaultHandleEventOperation ]
]

{ #category : 'accessing' }
WeblyWalkThrough >> handleEventOperation: aString [

	handleEventOperation := aString
]

{ #category : 'request handling' }
WeblyWalkThrough >> handleRequest: aZnRequest [

	| path method |
	aZnRequest uri isSlash ifTrue: [
		^ self responseOk: (ZnStringEntity html: self frontPage) ].
	path := aZnRequest uri segments.
	path size = 1 ifTrue: [
			path first = 'webly.js' ifTrue: [
					^ self responseOk: ((ZnStringEntity type:
								    (ZnMimeType applicationJavascript charSet: 'utf-8'))
							   string: self webly_js;
							   encoder;
							   yourself) ].
			path first = 'display' ifTrue: [ ^ self display ].
			path first = 'event' ifTrue: [
				^ self event:
					  (NeoJSONReader fromString: aZnRequest entity contents) ] ].
	path size > 2 ifTrue: [ ^ self responseNotFound: aZnRequest url ].
	path = #( 'favicon.ico' ) ifTrue: [
		^ self responseNotFound: aZnRequest url ].
	method := aZnRequest method asLowercase.
	method = 'options' ifTrue: [
			^ self responseOk: ((ZnStringEntity type: ZnMimeType textPlain)
					   string: '';
					   yourself) ].
	^ self handleApi: aZnRequest
]

{ #category : 'initialize-release' }
WeblyWalkThrough >> initialize [

	super initialize.
	animation := ViennaAnimation default.
	translator := WWTTranslator new.
	displayEnabled := false.
	guiModule := self defaultGuiModule.
	displayOperation := self defaultDisplayOperation.
	handleEventOperation := self defaultHandleEventOperation
]

{ #category : 'testing' }
WeblyWalkThrough >> isPublished [

	^ self class server isRunning and: [
		  self class server delegate == self ]
]

{ #category : 'evaluating' }
WeblyWalkThrough >> plainAt: aString [

	^ animation plainAt: aString
]

{ #category : 'evaluating' }
WeblyWalkThrough >> plainAt: aString ifAbsent: aBlock [

	^ animation plainAt: aString ifAbsent: aBlock
]

{ #category : 'evaluating' }
WeblyWalkThrough >> plainAt: aString ifAbsentPut: aBlock [

	^ animation plainAt: aString ifAbsentPut: aBlock
]

{ #category : 'evaluating' }
WeblyWalkThrough >> plainAt: aString ifPresent: aBlock ifAbsent: anotherBlock [

	^ animation plainAt: aString ifPresent: aBlock ifAbsent: anotherBlock
]

{ #category : 'evaluating' }
WeblyWalkThrough >> plainAt: aString put: anObject [

	^ animation plainAt: aString put: anObject
]

{ #category : 'evaluating' }
WeblyWalkThrough >> plainEvaluate: aString [

	^ animation plainEvaluate: aString
]

{ #category : 'evaluating' }
WeblyWalkThrough >> plainEvaluate: aString ifError: aBlock [

	^ animation plainEvaluate: aString ifError: aBlock
]

{ #category : 'evaluating' }
WeblyWalkThrough >> plainEvaluate: aString in: moduleName ifError: errorBlock [

	^ animation plainEvaluate: aString in: moduleName ifError: errorBlock
]

{ #category : 'evaluating' }
WeblyWalkThrough >> plainExecute: aViennaNode in: moduleName ifError: errorBlock [

	^ animation
		  plainExecute: aViennaNode
		  in: moduleName
		  ifError: errorBlock
]

{ #category : 'javascript' }
WeblyWalkThrough >> printDisplayFunctionsOn: aStream [

	aStream nextPutAll: 'Webly.display = function () {'.
	self displayEnabled ifTrue: [
			aStream nextPutAll: '
    var req = new XMLHttpRequest();
    req.open("GET", "/display");
    req.timeout = 100000;
    req.onload = function () {while (Webly.displayElement.firstChild) Webly.displayElement.removeChild(Webly.displayElement.firstChild);Webly.displayElement.appendChild(req.responseXML.documentElement.childNodes[0]);};
    req.send();
' withUnixLineEndings ].
	aStream
		nextPutAll: '};';
		lf.
	self displayEnabled ifTrue: [
			aStream
				nextPutAll:
					'window.onload = function () {Webly.displayElement = document.getElementById("display");Webly.display();};';
				lf ]
]

{ #category : 'javascript' }
WeblyWalkThrough >> printDynamicWeblyFunctionsOn: aStream [

	(globalNamesAndNumArgs collect: #first) asSet asSortedCollection do: [
			:mod |
			aStream
				nextPutAll: 'Webly.';
				nextPutAll: mod;
				nextPutAll: ' = {};';
				lf ].
	globalNamesAndNumArgs do: [ :triple |
			aStream
				nextPutAll: 'Webly.';
				nextPutAll: triple first;
				nextPut: $.;
				nextPutAll: triple second;
				nextPutAll: ' = function('.
			(1 to: triple third) do: [ :i |
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

{ #category : 'javascript' }
WeblyWalkThrough >> printEventFunctionsOn: aStream [

	self displayEnabled ifTrue: [
			aStream nextPutAll: '
Webly.event = function(event, continuation) { 
    var req = new XMLHttpRequest();
    var arguments = {};
    arguments.type = event.type;
    arguments.target = event.target.getAttribute("identifier");
    if (event.type == "click") { 
        arguments.x = event.offsetX;
        arguments.y = event.offsetY;
    }
    if (event.type = "change") { 
        arguments.value = event.target.value;
    }
    req.open("POST", "/event");
    req.setRequestHeader("Content-Type", "application/json");
    req.onload = function () { 
        while (Webly.displayElement.firstChild)
            Webly.displayElement.removeChild(Webly.displayElement.firstChild);
        Webly.displayElement.appendChild(req.responseXML.documentElement.childNodes[0]);
        if (continuation) continuation();
    };
    req.send(JSON.stringify(arguments));
};
' withUnixLineEndings ]
]

{ #category : 'responses' }
WeblyWalkThrough >> responseNotFound: aString [

	| response |
	response := ZnResponse notFound: aString.
	response headers
		at: 'Access-Control-Allow-Origin' put: '*';
		at: 'Access-Control-Allow-Headers' put: 'Content-Type';
		at: 'Access-Control-Allow-Content-Type'
		put: ZnMimeType applicationJson printString.
	^ response
]

{ #category : 'responses' }
WeblyWalkThrough >> responseOk: anZnEntity [

	| response |
	response := ZnResponse ok: anZnEntity.
	response headers
		at: 'Access-Control-Allow-Origin' put: '*';
		at: 'Access-Control-Allow-Headers' put: 'Content-Type';
		at: 'Access-Control-Allow-Content-Type'
		put: ZnMimeType applicationJson printString.
	^ response
]

{ #category : 'responses' }
WeblyWalkThrough >> responseServerError: aStrng [

	| response |
	response := ZnResponse serverError: aStrng.
	response headers
		at: 'Access-Control-Allow-Origin' put: '*';
		at: 'Access-Control-Allow-Headers' put: 'Content-Type';
		at: 'Access-Control-Allow-Content-Type'
		put: ZnMimeType applicationJson printString.
	^ response
]

{ #category : 'accessing' }
WeblyWalkThrough >> specification [

	^ animation specification
]

{ #category : 'accessing' }
WeblyWalkThrough >> specification: aString [

	self updateGlobalNamesAndNumArgs: aString.
	animation specification: aString
]

{ #category : 'evaluating' }
WeblyWalkThrough >> specification: aStringOrViennaNode ifError: errorBlock [

	^ animation specification: aStringOrViennaNode ifError: errorBlock
]

{ #category : 'accessing' }
WeblyWalkThrough >> state [

	^ animation state
]

{ #category : 'accessing' }
WeblyWalkThrough >> state: aDictionary [

	animation state: aDictionary
]

{ #category : 'translating' }
WeblyWalkThrough >> taggedElement2xml: aString [

	| element |
	element := self taggedElementDecoder parse: aString.
	^ String streamContents: [ :stream |
			  stream nextPutAll:
				  '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">'.
			  element isPetit2Failure
				  ifTrue: [ aString ]
				  ifFalse: [
						  element isString
							  ifTrue: [
									  stream
										  nextPutAll:
											  '<text x="0" y="12" font-family="Helvetica" font-size="12" color="black">';
										  nextPutAll: element;
										  nextPutAll: '</text>' ]
							  ifFalse: [ element printXmlOn: stream ] ].
			  stream nextPutAll: '</svg>' ]
]

{ #category : 'accessing' }
WeblyWalkThrough >> taggedElementDecoder [

	^ taggedElementDecoder ifNil: [
		  taggedElementDecoder := ViennaVDMTaggedElementDecoder new ]
]

{ #category : 'translating' }
WeblyWalkThrough >> translateFromJson: aString [

	^ self translator jsonToVdmString: aString
]

{ #category : 'translating' }
WeblyWalkThrough >> translateToJson: aString [

	^ self translator vdmToJsonString: aString
]

{ #category : 'accessing' }
WeblyWalkThrough >> translator [

	^ translator
]

{ #category : 'accessing' }
WeblyWalkThrough >> translator: aWWTTranslator [

	translator := aWWTTranslator
]

{ #category : 'accessing' }
WeblyWalkThrough >> updateGlobalNamesAndNumArgs: aString [

	| ast |
	ast := ViennaVDMParser current parse: aString.
	(ast isPetit2Failure or: [ ast isEmpty ]) ifTrue: [
			globalNamesAndNumArgs := #(  ).
			^ self ].
	globalNamesAndNumArgs := Array streamContents: [ :stream |
			                         (ast isViennaModularDocumentNode
				                          ifTrue: [ ast ]
				                          ifFalse: [ { ast } ]) do: [ :mod |
					                         | modName |
					                         modName := mod isViennaModuleNode
						                                    ifTrue: [ mod identifier ]
						                                    ifFalse: [
						                                    animation defaultModule ].
					                         mod allDescendantsDo: [ :node |
							                         node
								                         isViennaExplicitFunctionDefinitionNode
								                         ifTrue: [
										                         stream nextPut: {
												                         modName.
												                         node identifier.
												                         node parametersList first size } ].
							                         node
								                         isViennaExplicitOperationDefinitionNode
								                         ifTrue: [
										                         stream nextPut: {
												                         modName.
												                         node identifier.
												                         node parameters size } ] ] ] ]
]

{ #category : 'request handling' }
WeblyWalkThrough >> value: aZnRequest [

	^ self handleRequest: aZnRequest
]

{ #category : 'accessing' }
WeblyWalkThrough >> viennaVisualsPage [

	^ '<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<title>Webly Walk-Through</title>
<script type="application/javascript" src="webly.js" charset="utf-8"></script>
</head>
<body>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="display" style="border: solid 1px black;">
</svg>
<script>
var display = document.getElementById("display");
display.setAttribute("width", window.innerWidth-25);
display.setAttribute("height", window.innerHeight-25);
</script>
</body></html>' withUnixLineEndings
]

{ #category : 'javascript' }
WeblyWalkThrough >> webly_js [

	^ String streamContents: [ :stream |
			  stream nextPutAll: 'Webly = {};
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
