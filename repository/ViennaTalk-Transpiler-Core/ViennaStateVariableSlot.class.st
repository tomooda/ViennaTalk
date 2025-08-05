Class {
	#name : 'ViennaStateVariableSlot',
	#superclass : 'InstanceVariableSlot',
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'meta-object-protocol' }
ViennaStateVariableSlot >> basicWrite: aValue to: anObject [

	<reflection: 'Object Modification - State modification'>
	^ self object: anObject instVarAt: index put: aValue
]
