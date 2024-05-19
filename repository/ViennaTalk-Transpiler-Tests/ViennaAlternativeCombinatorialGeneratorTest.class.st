Class {
	#name : 'ViennaAlternativeCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaAlternativeCombinatorialGeneratorTest >> testNext [

	| env generator result |
	env := {
		       ('x' -> 1).
		       ('y' -> 2) } asDictionary.
	generator := ViennaAlternativeCombinatorialGenerator withAll: {
			             (ViennaCallCombinatorialGenerator on: [ :e |
				              result := e at: 'x' ]).
			             (ViennaCallCombinatorialGenerator on: [ :e |
				              result := e at: 'y' ]) }.
	result := nil.
	self assert: (generator next: env).
	self assert: result equals: 1.
	self deny: (generator next: env).
	self assert: result equals: 2
]

{ #category : 'tests' }
ViennaAlternativeCombinatorialGeneratorTest >> testStep [

	| env generator result |
	env := {
		       ('x' -> 1).
		       ('y' -> 2) } asDictionary.
	generator := ViennaAlternativeCombinatorialGenerator withAll: {
			             (ViennaCallCombinatorialGenerator on: [ :e |
				              result := e at: 'x' ]).
			             (ViennaCallCombinatorialGenerator on: [ :e |
				              result := e at: 'y' ]) }.
	result := nil.
	self assert: (generator step: env).
	self deny: (generator step: env)
]

{ #category : 'tests' }
ViennaAlternativeCombinatorialGeneratorTest >> testValue [

	| env generator result |
	env := {
		       ('x' -> 1).
		       ('y' -> 2) } asDictionary.
	generator := ViennaAlternativeCombinatorialGenerator withAll: {
			             (ViennaCallCombinatorialGenerator on: [ :e |
				              result := e at: 'x' ]).
			             (ViennaCallCombinatorialGenerator on: [ :e |
				              result := e at: 'y' ]) }.
	result := nil.
	generator value: env.
	self assert: result equals: 1.
	generator value: env.
	self assert: result equals: 1.
	self assert: (generator step: env).
	generator value: env.
	self assert: result equals: 2
]
