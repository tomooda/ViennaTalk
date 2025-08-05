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

{ #category : 'evaluating' }
ViennaTranspiledModularDocumentForExecutionTracing >> sequenceDiagramFromExpression: aString [

	self evaluateExpression: aString ifError: [ ^ nil ]
]
