Class {
	#name : 'ViennaTranspiledModularDocumentForExecutionTracing',
	#superclass : 'ViennaTranspiledModularDocument',
	#instVars : [
		'_recorder'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Transpiler',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Transpiler'
}

{ #category : 'instance creation' }
ViennaTranspiledModularDocumentForExecutionTracing class >> fromAnimation: aViennaAnimation [

	| document reader |
	document := self transpilerClass new generate:
		            aViennaAnimation specification.
	reader := ViennaReader new.
	aViennaAnimation state keysAndValuesDo: [ :globalName :value |
			| index moduleName localName |
			index := globalName indexOf: $`.
			index > 0 ifTrue: [
					moduleName := globalName copyFrom: 1 to: index - 1.
					localName := globalName copyFrom: index + 1 to: globalName size.
					document at: moduleName ifPresent: [ :module |
						module basicInstVarNamed: localName put: (reader parse: value) ] ] ].
	^ document
]

{ #category : 'class access' }
ViennaTranspiledModularDocumentForExecutionTracing class >> transpilerClass [

	^ ViennaTranspilerForExecutionTracing
]

{ #category : 'recording' }
ViennaTranspiledModularDocumentForExecutionTracing >> _recordOperationCall: aString args: anArray [

	_recorder call: aString args: anArray
]

{ #category : 'recording' }
ViennaTranspiledModularDocumentForExecutionTracing >> _recordOperationReturn: aString value: anObject [

	_recorder return: aString value: anObject
]

{ #category : 'recording' }
ViennaTranspiledModularDocumentForExecutionTracing >> _recordState [

	_recorder state: self state
]

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForExecutionTracing >> _recorder [

	^ _recorder
]

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForExecutionTracing >> _recorder: anObject [

	_recorder := anObject
]

{ #category : 'evaluating' }
ViennaTranspiledModularDocumentForExecutionTracing >> evaluateExpression: aString with: aViennaVDM2SmalltalkClass ifError: errorBlock [

	| value |
	^ _recorder
		  record: [
				  value := super
					           evaluateExpression: aString
					           with: aViennaVDM2SmalltalkClass
					           ifError: errorBlock ]
		  do: [ value ]
]

{ #category : 'evaluating' }
ViennaTranspiledModularDocumentForExecutionTracing >> evaluateNode: aViennaNode with: aViennaVDM2SmalltalkClass ifError: errorBlock [

	| value |
	^ _recorder
		  record: [
				  value := super
					           evaluateNode: aViennaNode
					           with: aViennaVDM2SmalltalkClass
					           ifError: errorBlock ]
		  do: [ value ]
]

{ #category : 'evaluating' }
ViennaTranspiledModularDocumentForExecutionTracing >> evaluateStatement: aString with: aViennaVDM2SmalltalkClass ifError: errorBlock [

	| value |
	^ _recorder
		  record: [
				  value := super
					           evaluateStatement: aString
					           with: aViennaVDM2SmalltalkClass
					           ifError: errorBlock ]
		  do: [ value ]
]

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForExecutionTracing >> executionTrace [

	^ _recorder output
]

{ #category : 'initialize' }
ViennaTranspiledModularDocumentForExecutionTracing >> initialize [

	super initialize.
	_recorder := ViennaExecutionTraceNullRecorder new
]

{ #category : 'initialize' }
ViennaTranspiledModularDocumentForExecutionTracing >> initialize: anInteger [

	super initialize: anInteger.
	_recorder := ViennaExecutionTraceNullRecorder new
]

{ #category : 'user interface' }
ViennaTranspiledModularDocumentForExecutionTracing >> sequenceDiagramSourceFromNode: aViennaNode in: aStringOrNil [

	self useSequenceDiagramRecorder: aViennaNode source.
	^ (self at: aStringOrNil ifAbsent: [ self ])
		  evaluateNode: aViennaNode ifError: [ ^ nil ];
		  executionTrace
]

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForExecutionTracing >> useSequenceDiagramRecorder: aString [

	_recorder := ViennaExecutionTraceRecorder forSequenceDiagram: aString
]
