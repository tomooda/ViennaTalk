Class {
	#name : 'ViennaCombinatorialGenerator',
	#superclass : 'Object',
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'testing' }
ViennaCombinatorialGenerator class >> isAbstract [

	^ self = ViennaCombinatorialGenerator
]

{ #category : 'operations' }
ViennaCombinatorialGenerator >> next: aDictionary [
	"execute the current trace path and step to the next path"

	self value: aDictionary.
	^ self step: aDictionary
]

{ #category : 'operations' }
ViennaCombinatorialGenerator >> reset [
	"reset the enumeration of the trace paths"

	^ self subclassResponsibility
]

{ #category : 'operations' }
ViennaCombinatorialGenerator >> step: aDictionary [
	"step to the next trace path, and answers whether the trace path is available or not"

	^ self subclassResponsibility
]

{ #category : 'operations' }
ViennaCombinatorialGenerator >> value: aDictionary [
	"execute the current trace path, or nil if all the combination has been exhausted"

	^ self subclassResponsibility
]
