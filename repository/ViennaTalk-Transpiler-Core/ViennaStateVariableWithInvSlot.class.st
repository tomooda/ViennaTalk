Class {
	#name : 'ViennaStateVariableWithInvSlot',
	#superclass : 'ViennaStateVariableSlot',
	#category : 'ViennaTalk-Transpiler-Core-TranspiledObject',
	#package : 'ViennaTalk-Transpiler-Core',
	#tag : 'TranspiledObject'
}

{ #category : 'code generation' }
ViennaStateVariableWithInvSlot >> emitStore: aMethodBuilder [
	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #writeToSlot:of:
]

{ #category : 'meta-object-protocol' }
ViennaStateVariableWithInvSlot >> write: aValue to: anObject [

	self basicWrite: aValue to: anObject.
	anObject inv.
	^ aValue
]
