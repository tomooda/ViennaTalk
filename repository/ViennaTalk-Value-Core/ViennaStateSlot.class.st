Class {
	#name : 'ViennaStateSlot',
	#superclass : 'InstanceVariableSlot',
	#category : 'ViennaTalk-Value-Core',
	#package : 'ViennaTalk-Value-Core'
}

{ #category : 'meta-object-protocol' }
ViennaStateSlot >> basicWrite: aValue to: anObject [

	^ super write: aValue to: anObject
]

{ #category : 'code generation' }
ViennaStateSlot >> emitStore: aMethodBuilder [
	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #writeToSlot:of:
]

{ #category : 'meta-object-protocol' }
ViennaStateSlot >> write: aValue to: anObject [
	super write: aValue to: anObject.
	anObject inv.
	^ aValue
]
