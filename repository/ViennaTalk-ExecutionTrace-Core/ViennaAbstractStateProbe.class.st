Class {
	#name : 'ViennaAbstractStateProbe',
	#superclass : 'ViennaCompiledMethodBlock',
	#instVars : [
		'name',
		'source'
	],
	#category : 'ViennaTalk-ExecutionTrace-Core-Utilities',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Utilities'
}

{ #category : 'instance creation' }
ViennaAbstractStateProbe class >> name: aString receiver: aViennaTranspiledObject source: anotherString [

	^ self new
		  name: aString;
		  receiver: aViennaTranspiledObject;
		  source: anotherString;
		  yourself
]

{ #category : 'controlling' }
ViennaAbstractStateProbe >> ifCompiledDo: aBlock [

	^ compiledMethod ifNotNil: [ aBlock cull: self ]
]

{ #category : 'testing' }
ViennaAbstractStateProbe >> isCompiled [

	^ compiledMethod notNil
]

{ #category : 'accessing' }
ViennaAbstractStateProbe >> moduleName [

	^ receiver class moduleName
]

{ #category : 'accessing' }
ViennaAbstractStateProbe >> moduleNode [

	^ receiver class specification
]

{ #category : 'accessing' }
ViennaAbstractStateProbe >> name [

	^ name
]

{ #category : 'accessing' }
ViennaAbstractStateProbe >> name: aString [

	name := aString
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
ViennaAbstractStateProbe >> source [

	^ source
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
		                    with: ViennaTranspilerForExecutionTracing new
		                    ifError: [ :msg | ^ self error: msg ].
	compiledMethod := [
		                  OpalCompiler new
			                  source: transpiledSource;
			                  logged: false;
			                  receiver: receiver;
			                  compile ]
		                  on: Error
		                  do: [ :ex | ex return: nil ].
	source := aString
]
