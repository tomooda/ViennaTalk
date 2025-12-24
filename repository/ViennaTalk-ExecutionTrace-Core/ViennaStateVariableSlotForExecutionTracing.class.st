Class {
	#name : 'ViennaStateVariableSlotForExecutionTracing',
	#superclass : 'ViennaStateVariableWithInvSlot',
	#category : 'ViennaTalk-ExecutionTrace-Core-Transpiler',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Transpiler'
}

{ #category : 'meta-object-protocol' }
ViennaStateVariableSlotForExecutionTracing >> write: aValue to: anObject [

	self basicWrite: aValue to: anObject.
	anObject _document _recorder pauseRecordingDuring: [ anObject inv ].
	anObject _stateChanged: self name.
	^ aValue
]
