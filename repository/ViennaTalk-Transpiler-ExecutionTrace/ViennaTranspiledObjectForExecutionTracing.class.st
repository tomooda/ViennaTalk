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
