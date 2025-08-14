Class {
	#name : 'ViennaStateVariableSlotForExecutionTracing',
	#superclass : 'ViennaStateVariableWithInvSlot',
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Transpiler',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Transpiler'
}

{ #category : 'meta-object-protocol' }
ViennaStateVariableSlotForExecutionTracing >> write: aValue to: anObject [

	self basicWrite: aValue to: anObject.
	anObject inv.
	anObject _stateChanged: self name.
	^ aValue
]
