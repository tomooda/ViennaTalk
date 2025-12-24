Class {
	#name : 'ViennaTranspiledModularDocumentForExecutionTracing',
	#superclass : 'ViennaTranspiledModularDocument',
	#instVars : [
		'_recorder'
	],
	#category : 'ViennaTalk-ExecutionTrace-Core-Transpiler',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Transpiler'
}

{ #category : 'instance creation' }
ViennaTranspiledModularDocumentForExecutionTracing class >> fromAnimation: aViennaAnimation [

	| spec document reader |
	spec := aViennaAnimation specification.
	spec isString ifTrue: [ spec := spec asViennaDocumentAst ].
	document := self transpilerClass new generate: spec.
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

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForExecutionTracing >> _executionTrace [

	^ _recorder output
]

{ #category : 'recording' }
ViennaTranspiledModularDocumentForExecutionTracing >> _recordOperationCall: aString module: anotherString args: anArray [

	_recorder call: aString module: anotherString args: anArray
]

{ #category : 'recording' }
ViennaTranspiledModularDocumentForExecutionTracing >> _recordOperationReturn: aString module: anotherString value: anObject [

	_recorder return: aString module: anotherString value: anObject
]

{ #category : 'recording' }
ViennaTranspiledModularDocumentForExecutionTracing >> _recordStateDiff: aBlock [

	_recorder stateDiffBlock: aBlock
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
		  _executionTrace
]

{ #category : 'user interface' }
ViennaTranspiledModularDocumentForExecutionTracing >> stateDiagramSourceFromNode: aViennaNode probes: aCollectionOfBlock in: aStringOrNil [

	self useStateDiagramRecorder: aCollectionOfBlock.
	^ (self at: aStringOrNil ifAbsent: [ self ])
		  evaluateNode: aViennaNode ifError: [ ^ nil ];
		  _executionTrace
]

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForExecutionTracing >> useCSVRecorder: aDictionary [

	^ _recorder := ViennaExecutionTraceRecorder forCSV: aDictionary
]

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForExecutionTracing >> useEventRecorder: aDictionary [

	^ _recorder := ViennaExecutionTraceEventRecorder initialState:
		               aDictionary
]

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForExecutionTracing >> useSequenceDiagramRecorder: aString [

	^ _recorder := ViennaExecutionTraceRecorder forSequenceDiagram:
		               aString
]

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForExecutionTracing >> useStateDiagramRecorder: aCollectionOfBlockClosure [

	^ _recorder := ViennaExecutionTraceRecorder forStateDiagram:
		               aCollectionOfBlockClosure asArray
]
