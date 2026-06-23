Class {
	#name : 'ViennaTranspiledObjectForExecutionTracing',
	#superclass : 'ViennaTranspiledObject',
	#category : 'ViennaTalk-ExecutionTrace-Core-Transpiler',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Transpiler'
}

{ #category : 'defaults' }
ViennaTranspiledObjectForExecutionTracing >> _defaultProbes [

	^ Array streamContents: [ :stream | self _defaultProbesInto: stream ]
]

{ #category : 'defaults' }
ViennaTranspiledObjectForExecutionTracing >> _defaultProbesInto: aStream [

	self class specification ifNotNil: [ :moduleNode |
			moduleNode stateDefinition ifNotNil: [ :stateDefinition |
					stateDefinition fieldsDo: [ :field |
							| identifier |
							identifier := field identifier.
							(ViennaAbstractStateProbe
								 name: identifier
								 receiver: self
								 source: identifier) ifCompiledDo: [ :probe |
								aStream nextPut: probe ] ] ] ]
]

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
