Class {
	#name : #ViennaStateSlot,
	#superclass : #InstanceVariableSlot,
	#category : 'ViennaTalk-Parser-Code Generators'
}

{ #category : #'code generation' }
ViennaStateSlot >> emitStore: aMethodBuilder [
	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #writeToSlot:of:
]

{ #category : #'meta-object-protocol' }
ViennaStateSlot >> write: aValue to: anObject [
	super write: aValue to: anObject.
	anObject inv.
	^ aValue
]
