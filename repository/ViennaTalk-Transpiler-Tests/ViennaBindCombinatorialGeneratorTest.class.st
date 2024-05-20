"
A ViennaBindCombinatorialGeneratorTest is a test class for testing the behavior of ViennaBindCombinatorialGenerator
"
Class {
	#name : 'ViennaBindCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaBindCombinatorialGeneratorTest >> testNext [

	| rootEnv env generator |
	rootEnv := { ('a' -> 1) } asDictionary.
	generator := ViennaBindCombinatorialGenerator
		             collection: { 10. 20 }
		             bindBlock: [ :e :v |
			             {
				             { ('x' -> v) } asDictionary.
				             { ('x' -> (v + 1)) } asDictionary } ].
	env := rootEnv copy.
	self assert: (generator next: env).
	self assert: (env at: 'a') equals: 1.
	self assert: (env at: 'x') equals: 10.

	env := rootEnv copy.
	self assert: (generator next: env).
	self assert: (env at: 'a') equals: 1.
	self assert: (env at: 'x') equals: 11.

	env := rootEnv copy.
	self assert: (generator next: env).
	self assert: (env at: 'a') equals: 1.
	self assert: (env at: 'x') equals: 20.

	env := rootEnv copy.
	self deny: (generator next: env).
	self assert: (env at: 'a') equals: 1.
	self assert: (env at: 'x') equals: 21
]

{ #category : 'tests' }
ViennaBindCombinatorialGeneratorTest >> testStep [

	| rootEnv env generator |
	rootEnv := { ('a' -> 1) } asDictionary.
	generator := ViennaBindCombinatorialGenerator
		             collection: { 10. 20 }
		             bindBlock: [ :e :v |
			             {
				             { ('x' -> v) } asDictionary.
				             { ('x' -> (v + 1)) } asDictionary } ].
	env := rootEnv copy.
	generator value: env.
	self assert: (env at: 'a') equals: 1.
	self assert: (env at: 'x') equals: 10.
	env := rootEnv copy.
	self assert: (generator step: env).
	generator value: env.
	self assert: (env at: 'a') equals: 1.
	self assert: (env at: 'x') equals: 11.
	env := rootEnv copy.
	self assert: (generator step: env).
	generator value: env.
	self assert: (env at: 'a') equals: 1.
	self assert: (env at: 'x') equals: 20.
	env := rootEnv copy.
	self assert: (generator step: env).
	generator value: env.
	self assert: (env at: 'a') equals: 1.
	self assert: (env at: 'x') equals: 21.
	self deny: (generator step: env)
]

{ #category : 'tests' }
ViennaBindCombinatorialGeneratorTest >> testValue [

	| env generator |
	env := { ('a' -> 1) } asDictionary.
	generator := ViennaBindCombinatorialGenerator
		             collection: { 10. 20. 30 }
		             bindBlock: [ :e :v |
			             {
				             { ('x' -> v) } asDictionary.
				             { ('x' -> (v + 1)) } asDictionary } ].
	generator value: env.
	self assert: (env at: 'a') equals: 1.
	self assert: (env at: 'x') equals: 10.
	generator value: env.
	self assert: (env at: 'a') equals: 1.
	self assert: (env at: 'x') equals: 10
]
