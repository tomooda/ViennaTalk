Class {
	#name : 'ViennaFullStateVariableSlot',
	#superclass : 'ViennaStateVariableSlot',
	#instVars : [
		'checksInvariant',
		'records'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'meta-object-protocol' }
ViennaFullStateVariableSlot >> basicWrite: aValue to: anObject [

	<reflection: 'Object Modification - State modification'>
	^ self object: anObject instVarAt: index put: aValue
]

{ #category : 'accessing' }
ViennaFullStateVariableSlot >> checksInvariant [

	^ checksInvariant
]

{ #category : 'accessing' }
ViennaFullStateVariableSlot >> checksInvariant: aBoolean [

	checksInvariant := aBoolean
]

{ #category : 'code generation' }
ViennaFullStateVariableSlot >> emitStore: aMethodBuilder [
	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #writeToSlot:of:
]

{ #category : 'initialization' }
ViennaFullStateVariableSlot >> initialize [

	super initialize.
	checksInvariant := true.
	records := false
]

{ #category : 'accessing' }
ViennaFullStateVariableSlot >> records [

	^ records
]

{ #category : 'accessing' }
ViennaFullStateVariableSlot >> records: aBoolean [

	records := aBoolean = true
]

{ #category : 'meta-object-protocol' }
ViennaFullStateVariableSlot >> write: aValue to: anObject [

	self basicWrite: aValue to: anObject.
	checksInvariant ifTrue: [ anObject inv ].
	records ifTrue: [ anObject _recordState ].
	^ aValue
]
