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

{ #category : 'accessing' }
ViennaCombinatorialGenerator >> next [

	| result |
	result := self peek.
	self step.
	^ result
]

{ #category : 'accessing' }
ViennaCombinatorialGenerator >> peek [
	"Answers an evaluatable (responds to value: env) to perform the current trace path, or nil if all the combination has been exhausted"

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaCombinatorialGenerator >> reset [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaCombinatorialGenerator >> step [
	"step to the next trace path"

	^ self subclassResponsibility
]
