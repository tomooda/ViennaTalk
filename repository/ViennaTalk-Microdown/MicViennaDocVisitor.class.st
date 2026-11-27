Class {
	#name : 'MicViennaDocVisitor',
	#superclass : 'MicHTMLVisitor',
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

{ #category : 'visiting' }
MicViennaDocVisitor >> visitViennaEval: aMicViennaEvalBlock [

	| code |
	canvas
		newLine;
		nextPutAll: '<br>'.
	code := canvas tag
		        name: 'code';
		        parameterAt: 'class' put: 'vdm';
		        parameterAt: 'vienna' put: 'eval';
		        yourself.
	aMicViennaEvalBlock moduleName ifNotNil: [ :module | code parameterAt: 'module' put: module ].
	aMicViennaEvalBlock prestates ifNotNil: [ :prestates | code parameterAt: 'prestates' put: (',' join: prestates) ].
	aMicViennaEvalBlock poststates ifNotNil: [ :poststates | code parameterAt: 'poststates' put: (',' join: poststates) ].
	aMicViennaEvalBlock diagrams ifNotNil: [ :diagrams | code parameterAt: 'diagrams' put: (',' join: diagrams) ].
	code with: aMicViennaEvalBlock body.
	canvas
		nextPutAll: '<br>';
		newLine
]

{ #category : 'visiting' }
MicViennaDocVisitor >> visitViennaExec: aMicViennaExecBlock [

	| code |
	canvas
		newLine;
		nextPutAll: '<br>'.
	code := canvas tag
		        name: 'code';
		        parameterAt: 'class' put: 'vdm';
		        parameterAt: 'vienna' put: 'eval';
		        yourself.
	aMicViennaExecBlock moduleName ifNotNil: [ :module | code parameterAt: 'module' put: module ].
	aMicViennaExecBlock prestates ifNotNil: [ :prestates | code parameterAt: 'prestates' put: (',' join: prestates) ].
	aMicViennaExecBlock poststates ifNotNil: [ :poststates | code parameterAt: 'poststates' put: (',' join: poststates) ].
	aMicViennaExecBlock diagrams ifNotNil: [ :diagrams | code parameterAt: 'diagrams' put: (',' join: diagrams) ].
	code with: aMicViennaExecBlock body.
	canvas
		nextPutAll: '<br>';
		newLine
]

{ #category : 'visiting' }
MicViennaDocVisitor >> visitViennaSource: aMicViennaSourceBlock [

	| code paths |
	canvas newLine.
	code := canvas tag
		        name: 'code';
		        parameterAt: 'class' put: 'vdm';
		        parameterAt: 'vienna' put: 'source';
		        yourself.
	paths := Array streamContents: [ :stream |
			         aMicViennaSourceBlock moduleName ifNotNil: [ :module | stream nextPut: module ].
			         aMicViennaSourceBlock body trim ifNotEmpty: [ :body | stream nextPut: body ] ].
	paths ifNotEmpty: [ code parameterAt: 'src' put: ('`' join: paths) ].
	code with: [ ].
	canvas
		nextPutAll: '<br>';
		newLine
]

{ #category : 'visiting' }
MicViennaDocVisitor >> visitViennaWatch: aMicViennaWatchBlock [

	| code |
	canvas
		newLine;
		nextPutAll: '<br>'.
	code := canvas tag
		        name: 'code';
		        parameterAt: 'class' put: 'vdm';
		        parameterAt: 'vienna' put: 'watch';
		        yourself.
	aMicViennaWatchBlock moduleName ifNotNil: [ :module | code parameterAt: 'module' put: module ].
	code with: aMicViennaWatchBlock body.
	canvas
		nextPutAll: '<br>';
		newLine
]
