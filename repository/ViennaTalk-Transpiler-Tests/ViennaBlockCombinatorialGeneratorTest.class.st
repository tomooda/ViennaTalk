Class {
	#name : 'ViennaBlockCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaBlockCombinatorialGeneratorTest >> testNext [

	| env generator result |
	env := { ('x' -> 1) } asDictionary.
	generator := ViennaBlockCombinatorialGenerator on: [ :e |
		             result := e at: 'x' ].
	result := nil.
	self deny: (generator next: env).
	self assert: result equals: 1.
	self assert: (generator value: env) isNil
]

{ #category : 'tests' }
ViennaBlockCombinatorialGeneratorTest >> testStep [

	| env generator |
	env := { ('x' -> 1) } asDictionary.
	generator := ViennaBlockCombinatorialGenerator on: [ :e | e at: 'x' ].
	self deny: (generator step: env)
]

{ #category : 'tests' }
ViennaBlockCombinatorialGeneratorTest >> testValue [

	| generator env result |
	env := { ('x' -> 1) } asDictionary.
	generator := ViennaBlockCombinatorialGenerator on: [ :e |
		             result := e at: 'x' ].
	result := nil.
	generator value: env.
	self assert: result equals: 1.
	env at: 'x' put: 2.
	generator value: env.
	self assert: result equals: 2
]
