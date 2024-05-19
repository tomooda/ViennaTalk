Class {
	#name : 'ViennaCallCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaCallCombinatorialGeneratorTest >> testNext [

	| env generator result |
	env := { ('x' -> 1) } asDictionary.
	generator := ViennaCallCombinatorialGenerator on: [ :e |
		             result := e at: 'x' ].
	result := nil.
	self deny: (generator next: env).
	self assert: result equals: 1.
	self assert: (generator value: env) isNil
]

{ #category : 'tests' }
ViennaCallCombinatorialGeneratorTest >> testStep [

	| env generator |
	env := { ('x' -> 1) } asDictionary.
	generator := ViennaCallCombinatorialGenerator on: [ :e | e at: 'x' ].
	self deny: (generator step: env)
]

{ #category : 'tests' }
ViennaCallCombinatorialGeneratorTest >> testValue [

	| generator env result |
	env := { ('x' -> 1) } asDictionary.
	generator := ViennaCallCombinatorialGenerator on: [ :e |
		             result := e at: 'x' ].
	result := nil.
	generator value: env.
	self assert: result equals: 1.
	env at: 'x' put: 2.
	generator value: env.
	self assert: result equals: 2
]
