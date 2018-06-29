Class {
	#name : #VDMPad,
	#superclass : #Object,
	#instVars : [
		'handlerMap',
		'engine'
	],
	#classVars : [
		'Server'
	],
	#category : 'ViennaTalk-VDMPad-Core'
}

{ #category : #defaults }
VDMPad class >> defaultPort [
	^ 8085
]

{ #category : #servicing }
VDMPad class >> flushServer [
	"VDMPad flushServer"

	Server
		ifNotNil: [ 
			Server stop.
			Server unregister.
			Server := nil ]
]

{ #category : #servicing }
VDMPad class >> installHandler [
	"VDMPad installHandler"

	self server delegate: self new
]

{ #category : #'instance creation' }
VDMPad class >> on: aViennaEngine [
	^ self new
		engine: aViennaEngine;
		yourself
]

{ #category : #servicing }
VDMPad class >> server [
	^ Server
		ifNil: [ 
			Server := (ZnMultiThreadedServer on: self defaultPort)
				register;
				start;
				yourself ]
]

{ #category : #pages }
VDMPad >> aboutPage [
	| page|
	page := String new writeStream.
	page nextPutAll: '<html>'.
	page cr; nextPutAll: '<head>'.
	page cr; nextPutAll: '<title>about VDMPad</title>'.
	page cr; nextPutAll: '</head>'.
	page cr; nextPutAll: '<body>'.
	page cr; nextPutAll: '<div id="all" style="width: 640px">'.
	page cr; nextPutAll: '<div id="main" style="float: right; width: 560px">'.
	page cr; nextPutAll: '<div id="title">'.
	page cr; nextPutAll: '<div style="float: left; font-family: Helvetica, sans-serif; font-size:40px; font-weight: 100">about VDMPad 2.0</div> '.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '<div id="ide" style="width: 100%; float: right">'.
	page cr; nextPutAll: '<p>author: Tomohiro Oda</p>'.
	page cr; nextPutAll: '<p>copyright: Tomohiro Oda and Software Research Associates, Inc.</p>'.
	page cr; nextPutAll: '<p>license: the MIT license</p>'.
	page cr; nextPutAll: '<hr>'.
	page cr; nextPutAll: '<p>VDMPad is built on <a href="http://www.squeak.org/" target="squeak">Squeak Smalltalk</a> and the following packages.'.
	page cr; nextPutAll: '<ul><li><a target="modules" href="http://www.squeaksource.com/OSProcess.html">OSProcess</a></li>'.
	page cr; nextPutAll: '<li><a target="modules" href="http://www.squeaksource.com/WebClient.html">WebClient</a></li>'.
	page cr; nextPutAll: '<li><a target="modules" href="http://source.lukas-renggli.ch/petit.html">PetitParser</a></li>'.
	page cr; nextPutAll: '</ul></p>'.
	page cr; nextPutAll: '<p>VDMPad also uses VDMJ to animate VDM-SL specs.'.
	page cr; nextPutAll: '<ul><li><a target="VDMJ" href="https://sites.google.com/site/nickbattle/home/vdmj">VDMJ</a></li></ul></p>'.
	page cr; nextPutAll: '<p>VDMPad contains JavaScript programs listed below.'.
	page cr; nextPutAll: '<ul><li><a target="javascript" href="https://github.com/julianlam/tabIndent.js">tabIndent.js</a></li>'.
	page cr; nextPutAll: '<li><a target="javascript" href="https://github.com/eligrey/Blob.js">Blob.js</a></li>'.
	page cr; nextPutAll: '<li><a target="javascript" href="https://github.com/eligrey/FileSaver.js">FileSaver.js</a></li>'.
	page cr; nextPutAll: '<li><a target="javascript" href="http://codemirror.net/">CodeMirror</a></li></ul></p>'.
	page cr; nextPutAll: 'The author(s) of VDMPad deeply appreciate creators and contributors of the above mentioned great pieces of software.'.
	page cr; nextPutAll: '<hr><pre>Copyright (c) 2013 Tomohiro Oda and Software Research Associates, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.</pre>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '</body>'.
	page cr; nextPutAll: '</html>'.
	^ page contents
]

{ #category : #private }
VDMPad >> engine [
	^ engine
]

{ #category : #'pages-api' }
VDMPad >> eval: aZnRequest [
	| vdm10 rtc params source expression states triple json |
	params := aZnRequest contentType = 'application/json'
		ifTrue: [ NeoJSONReader fromString: aZnRequest entity ]
		ifFalse: [ aZnRequest mergedFields ].
	vdm10 := (params at: 'classic' ifAbsent: [  ]) isNil.
	rtc := (params at: 'ignoreRuntimeChecking' ifAbsent: [  ]) isNil.
	source := (params at: 'source' ifAbsent: [ String new ]) withBlanksTrimmed.
	states := Dictionary new.
	params
		keysAndValuesDo: [ :k :v | 
			| key value |
			key := k.
			value := v.
			((key includes: $`) and: [ value withBlanksTrimmed notEmpty ])
				ifTrue: [ 
					(states at: (key copyFrom: 1 to: (key indexOf: $`) - 1) ifAbsentPut: [ Dictionary new ])
						at: (key copyFrom: (key indexOf: $`) + 1 to: key size)
						put: ((value copyReplaceAll: String cr with: ' ') copyReplaceAll: String lf with: ' ') ] ].
	expression := ((params at: 'expression' ifAbsent: [ String new ]) copyReplaceAll: String cr with: ' ')
		copyReplaceAll: String lf
		with: ' '.
	triple := self engine
		evaluate: expression
		specification: source
		states: states
		vdm10: vdm10
		rtc: rtc.	"self log: anHttpRequest remoteHost source: source states: states
	expression: expression value: triple first message: triple third."
	json := Dictionary new.
	json
		at: 'source' put: source;
		at: 'expression' put: expression;
		at: 'value' put: (triple first ifNil: [ String new ]);
		at: 'message' put: (self tailerErrorMessage: triple third).
	triple second
		keysAndValuesDo: [ :moduleName :bindings | bindings keysAndValuesDo: [ :varName :value | json at: moduleName , '`' , varName put: value ] ].
	^ self responseJSON: json
]

{ #category : #'request handling' }
VDMPad >> handleRequest: aZnRequest [
	| path map |
	path := aZnRequest uri isSlash
		ifTrue: [ #('/') ]
		ifFalse: [ aZnRequest uri segments ].
	map := handlerMap.
	path
		do: [ :name | 
			map := map at: name ifAbsent: [ ^ self responseNotFound: aZnRequest uri ].
			map isClosure
				ifTrue: [ ^ map cull: aZnRequest ].
			map isSymbol
				ifTrue: [ ^ self perform: map with: aZnRequest ] ].
	^ self responseNotFound: aZnRequest uri
]

{ #category : #'initialize-release' }
VDMPad >> initialize [
	super initialize.
	engine := ViennaVDMJ bank: 16.
	handlerMap := Dictionary new.
	handlerMap at: '/' put: [ self responseHtml: self mainPage ].
	handlerMap at: 'about.html' put: [ self responseHtml: self aboutPage ].
	handlerMap at: 'VDMJcopyright.html' put: [ self responseHtml: self vdmjCopyrightPage ].
	handlerMap at: 'eval' put: #eval:
]

{ #category : #pages }
VDMPad >> mainPage [
	| page |
	page := String new writeStream.
	page nextPutAll: '<html ondragenter="return false;" ondragover="return false;" 
        ondrop="return VDMPad.acceptDroppedFile(event);">'.
	page cr; nextPutAll: '<head>'.
	page cr; nextPutAll: '<title>VDMPad</title>'.
	page cr; nextPutAll: '<script src="/blob.js"></script>'.
	page cr; nextPutAll: '<link rel="stylesheet" href="/codemirror/theme/vdmpad.css">'.
	page cr; nextPutAll: '<link rel="stylesheet" href="/codemirror/lib/codemirror.css">'.
	page cr; nextPutAll: '<script src="/codemirror/lib/codemirror.js"></script>'.
	page cr; nextPutAll: '<script src="/codemirror/addon/edit/matchbrackets.js"></script>'.
	page cr; nextPutAll: '<script src="/codemirror-vdm.js"></script>'.
	page cr; nextPutAll: '<script src="/codemirror/addon/iOS/iOSkeyboard.js"></script>'.
	page cr; nextPutAll: '<script src="/codemirror/addon/iOS/iOSselection.js"></script>'.
	page cr; nextPutAll: '<script src="/tabIndent.js"></script>'.
	page cr; nextPutAll: '<script src="/fileSaver.js"></script>'.
	page cr; nextPutAll: '<script src="/VDMPad.js"></script>'.
	page cr; nextPutAll: '</head>'.
	page cr; nextPutAll: '<body>'.
	page cr; nextPutAll: '<div id="all" style="width: 640px">'.
	page cr; nextPutAll: '<div id="menu" style="float: left; width: 80px">'.
	page cr; nextPutAll: '<div id="root_menu" style="margin-top: 40px" width: 100%><img id="rootMenuIcon" src="/rootMenuOff.png" alt="root menu"></div><div id="file_items" style="width: 100%"></div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '<div id="main" style="float: right; width: 560px">'.
	page cr; nextPutAll: '<div id="title">'.
	page cr; nextPutAll: '<div style="float: left; font-family: Helvetica, sans-serif; font-size:40px; font-weight: 100">VDMPad</div>  <div style="float: right; font-size: 10px; text-align: right">powered by Squeak Smalltalk with <a style="text-decoration: none" target="VDMJ" href="/VDMJcopyright.html">VDMJ</a><br><a style="text-decoration: none" target="aboutVDMPad" href="/about.html">about VDMPad</a></div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '<div id="ide" style="width: 100%; float: right">'.
	page cr; nextPutAll: '<form method="POST" action="/eval">'.
	page cr; nextPutAll: '<div style="border-width: 1px; border-style: solid; border-color: black"><textarea title="Enter a specificaton here." id="source" name="source"></textarea></div>'.
	page cr; nextPutAll: '<div id="states" style="margin-top: 20px"></div>'.
	page cr; nextPutAll: '<div align=right><input title="Initializes the states" type="button" onClick="VDMPad.init()" value="Initialize" style="cursor: pointer; background-color: white; width: 150px; height: 20px"></div>'.
	page cr; nextPutAll: '<div id="workspace" align=right style="margin-top: 30px">'.
	page cr; nextPutAll: '<div style="border-width: 1px; border-style: solid; border-color: black" align=left><textarea title="Write expressions to evaluate." id="expression"></textarea></div>'.
	page cr; nextPutAll: '<input title="Evaluates the expression selected in the above textbox" type="button" onClick="VDMPad.eval()" value="evaluate" style="cursor: pointer; background-color: #f0f0f0; width: 200px; height: 30px"><br>'.
	page cr; nextPutAll: '<input id="make it a testcase" title="Makes the previous evaluation as a testcase." type="button" onClick="VDMPad.addTestcase()" value="make it a testcase" style="visibility: hidden; cursor: pointer; background-color: #ffffff; width: 150px; height: 20px"><br>'.
	page cr; nextPutAll: '<textarea  title="Displays the return value of the evaluation." id="value" name="value" readonly  style="width: 100%; height: 50px; resize: vertical"></textarea></div>'.
	page cr; nextPutAll: '<div id="valueVisual"></div>'.
	page cr; nextPutAll: '<hr>'.
	page cr; nextPutAll: '<div title="Displays error messages"  id="message"></div>'.
	page cr; nextPutAll: '<div id="unittest"></div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '<script>var elems = document.getElementsByTagName("textarea"); for (var i = 0; i < elems.length; i++) {var e = elems[i]; if (e.getAttribute("id") != "source") tabIndent.render(e)}; </script>'.
	page cr; nextPutAll: '<script>VDMPad.setupIdeNodes();VDMPad.setupMenuNodes();</script>'.
	page cr; nextPutAll: '<script>VDMPad.loadFromLocalStorage();</script>'.
	page cr; nextPutAll: '</body>'.
	page cr; nextPutAll: '</html>'.
	^ page contents
]

{ #category : #private }
VDMPad >> responseBinary: aByteArray [
	^ ZnByteArrayEntity with: aByteArray type: ZnMimeType applicationOctetStream 
]

{ #category : #private }
VDMPad >> responseHtml: aString [
	^ ZnResponse ok: (ZnStringEntity html: aString)
]

{ #category : #private }
VDMPad >> responseJS: aString [
	^ ZnResponse ok: (ZnStringEntity with: aString type: ZnMimeType applicationJavascript)
]

{ #category : #private }
VDMPad >> responseJSON: anObject [
	^ ZnResponse
		ok:
			(ZnStringEntity
				with:
					(String
						streamContents: [ :stream | 
							(NeoJSONWriter on: stream)
								asciiOnly: true;
								nextPut: anObject ])
				type: ZnMimeType applicationJson)
]

{ #category : #private }
VDMPad >> responseNotFound: aUrl [
	^ ZnResponse notFound: aUrl
]

{ #category : #private }
VDMPad >> responsePNG: aByteArray [
	^ ZnByteArrayEntity with: aByteArray type: ZnMimeType imagePng 
]

{ #category : #private }
VDMPad >> responseText: aString [
	^ ZnResponse ok: (ZnStringEntity text: aString)
]

{ #category : #private }
VDMPad >> tailerErrorMessage: aString [
	| message |
	message := String new writeStream.
	aString linesDo: [ :line |
		| output |
		output := nil.
		(line includesSubString: 'Error') ifTrue: [
			output := line.
			(output includesSubString: 'at line') ifTrue: [
				output := output copyFrom: 1 to: (output size - (output reverse indexOf: $())
			]
		].
		output ifNotNil: [message nextPutAll: output; cr]].
	"^ message contents"
	^ aString
]

{ #category : #pages }
VDMPad >> vdmjCopyrightPage [
	| page|
	page := String new writeStream.
	page nextPutAll: '<html>'.
	page cr; nextPutAll: '<head>'.
	page cr; nextPutAll: '<title>about VDMJ</title>'.
	page cr; nextPutAll: '</head>'.
	page cr; nextPutAll: '<body>'.
	page cr; nextPutAll: '<div id="all" style="width: 640px">'.
	page cr; nextPutAll: '<div id="main" style="float: right; width: 560px">'.
	page cr; nextPutAll: '<div id="title">'.
	page cr; nextPutAll: '<div style="float: left; font-family: Helvetica, sans-serif; font-size:40px; font-weight: 100">about VDMJ</div> '.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '<div id="ide" style="width: 100%; float: right">'.
	page cr; nextPutAll: '<p>VDMPad uses VDMJ as an execution engine.'.
	page cr; nextPutAll: 'Please note that VDMJ is copyrighted and licensed independent of VDMPad.'.
	page cr; nextPutAll: 'Please visit the link below and the copyright notice for details.</p>'.
	page cr; nextPutAll: '<a target="VDMJHome" href="https://sites.google.com/site/nickbattle/home/vdmj"> VDMJ homepage</a><hr>'.
	page cr; nextPutAll: '<pre>/*******************************************************************************
 *
 *	Copyright (C) 2008-2013 Fujitsu Services Ltd.
 *
 *	Author: Nick Battle
 *
 *	VDMJ is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *
 *	VDMJ is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with VDMJ.  If not, see <http://www.gnu.org/licenses/>.
 *
 ******************************************************************************/
</pre>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '</div>'.
	page cr; nextPutAll: '</body>'.
	page cr; nextPutAll: '</html>'.
	^ page contents
]
