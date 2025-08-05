Class {
	#name : 'ViennaTranspiledObjectForExecutionTracing',
	#superclass : 'ViennaTranspiledObject',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Transpiler',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Transpiler'
}

{ #category : 'private' }
ViennaTranspiledObjectForExecutionTracing >> _stateChanged [

	super _stateChanged.
	_document _recordState
]

{ #category : 'evaluating' }
ViennaTranspiledObjectForExecutionTracing >> evaluateExpression: aString with: aViennaVDM2SmalltalkClass ifError: errorBlock [

	| value |
	^ _document _recorder
		  record: [
				  value := super
					           evaluateExpression: aString
					           with: aViennaVDM2SmalltalkClass
					           ifError: errorBlock ]
		  do: [ value ]
]

{ #category : 'evaluating' }
ViennaTranspiledObjectForExecutionTracing >> evaluateNode: aViennaNode with: aViennaVDM2SmalltalkClass ifError: errorBlock [

	| value |
	^ _document _recorder
		  record: [
				  value := super
					           evaluateNode: aViennaNode
					           with: aViennaVDM2SmalltalkClass
					           ifError: errorBlock ]
		  do: [ value ]
]

{ #category : 'evaluating' }
ViennaTranspiledObjectForExecutionTracing >> evaluateStatement: aString with: aViennaVDM2SmalltalkClass ifError: errorBlock [

	| value |
	^ _document _recorder
		  record: [
				  value := super
					           evaluateStatement: aString
					           with: aViennaVDM2SmalltalkClass
					           ifError: errorBlock ]
		  do: [ value ]
]

{ #category : 'accessing' }
ViennaTranspiledObjectForExecutionTracing >> executionTrace [

	^ _document executionTrace
]
