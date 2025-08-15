Class {
	#name : 'ViennaAbstractStateProbe',
	#superclass : 'ViennaCompiledMethodBlock',
	#instVars : [
		'source'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Utilities',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Utilities'
}

{ #category : 'instance creation' }
ViennaAbstractStateProbe class >> receiver: aViennaTranspiledObject source: aString [

	^ self new
		  receiver: aViennaTranspiledObject;
		  source: aString;
		  yourself
]

{ #category : 'accessing' }
ViennaAbstractStateProbe >> moduleName [

	^ receiver moduleName
]

{ #category : 'accessing' }
ViennaAbstractStateProbe >> moduleNode [

	^ receiver class specification
]

{ #category : 'printing' }
ViennaAbstractStateProbe >> printOn: aStream [

	source ifNil: [ ^ super printOn: aStream ].
	self moduleName
		ifNotNil: [ :moduleName |
				aStream
					nextPutAll: moduleName;
					nextPutAll: '`(';
					nextPutAll: source;
					nextPut: $) ]
		ifNil: [ aStream nextPutAll: source ]
]

{ #category : 'compiler' }
ViennaAbstractStateProbe >> recompile [

	self source: source
]

{ #category : 'accessing' }
ViennaAbstractStateProbe >> source: aString [

	| expressionNode transpiledSource |
	expressionNode := aString asViennaExpressionAst.
	expressionNode isPetit2Failure ifTrue: [
		^ self error: 'Syntax error: ' , expressionNode message ].
	expressionNode parent: self moduleNode.
	expressionNode typecheck.
	transpiledSource := receiver class
		                    transpileNode: expressionNode
		                    with: ViennaTranspilerForExecutionTracing
		                    ifError: [ :msg | ^ self error: msg ].
	compiledMethod := OpalCompiler new
		                  source: transpiledSource;
		                  logged: false;
		                  receiver: receiver;
		                  compile.
	source := aString
]
