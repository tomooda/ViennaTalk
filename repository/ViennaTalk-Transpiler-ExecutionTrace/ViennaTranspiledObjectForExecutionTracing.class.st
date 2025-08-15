Class {
	#name : 'ViennaTranspiledObjectForExecutionTracing',
	#superclass : 'ViennaTranspiledObject',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Transpiler',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Transpiler'
}

{ #category : 'accessing' }
ViennaTranspiledObjectForExecutionTracing >> _executionTrace [

	^ _document _executionTrace
]

{ #category : 'private' }
ViennaTranspiledObjectForExecutionTracing >> _multipleStatesChanged: anArrayOfString [

	_document _recordStateDiff: [
			self class moduleName -> (anArrayOfString collect: [ :varName |
				 varName -> (self instVarNamed: varName) ]) ]
]

{ #category : 'accessing' }
ViennaTranspiledObjectForExecutionTracing >> _recorder [

	^ _document _recorder
]

{ #category : 'private' }
ViennaTranspiledObjectForExecutionTracing >> _stateChanged: aString [

	_document _recordStateDiff: [
		self class moduleName
		-> { (aString -> (self instVarNamed: aString)) } ]
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
