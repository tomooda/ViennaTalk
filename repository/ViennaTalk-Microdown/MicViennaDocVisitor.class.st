Class {
	#name : 'MicViennaDocVisitor',
	#superclass : 'MicHTMLVisitor',
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

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
	canvas newLine
]
