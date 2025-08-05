Class {
	#name : 'ViennaFullStateVariableSlot',
	#superclass : 'ViennaStateVariableSlot',
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'code generation' }
ViennaFullStateVariableSlot >> emitStore: aMethodBuilder [
	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #writeToSlot:of:
]

{ #category : 'meta-object-protocol' }
ViennaFullStateVariableSlot >> write: aValue to: anObject [

	self basicWrite: aValue to: anObject.
	anObject _stateChanged.
	^ aValue
]
