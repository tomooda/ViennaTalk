Class {
	#name : 'ViennaStateVariableWithInvSlot',
	#superclass : 'ViennaStateVariableSlot',
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
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
