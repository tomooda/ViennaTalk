Class {
	#name : 'ViennaRepeatCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaRepeatCombinatorialGeneratorTest >> testNext [

	| generator result |
	result := 0.
	generator := ViennaRepeatCombinatorialGenerator
		             range: (0 to: 2)
		             with: (ViennaBlockCombinatorialGenerator on: [ :env |
				              result := result + (env at: 'x') ]).
	self assert: (generator next: { ('x' -> 1) } asDictionary).
	self assert: result equals: 0.
	self assert: (generator next: { ('x' -> 1) } asDictionary).
	self assert: result equals: 1.
	self deny: (generator next: { ('x' -> 1) } asDictionary).
	self assert: result equals: 3
]

{ #category : 'tests' }
ViennaRepeatCombinatorialGeneratorTest >> testStep [

	| generator result1 result2 |
	generator := ViennaSequentialCombinatorialGenerator withAll: {
			             (ViennaBlockCombinatorialGenerator on: [ :env |
				              result1 := env at: 'x' ]).
			             (ViennaBlockCombinatorialGenerator on: [ :env |
				              result2 := env at: 'y' ]) }.
	self deny: (generator step: {
				 ('x' -> 1).
				 ('y' -> 2) } asDictionary)
]

{ #category : 'tests' }
ViennaRepeatCombinatorialGeneratorTest >> testValue [

	| generator result1 result2 |
	generator := ViennaSequentialCombinatorialGenerator withAll: {
			             (ViennaBlockCombinatorialGenerator on: [ :env |
				              result1 := env at: 'x' ]).
			             (ViennaBlockCombinatorialGenerator on: [ :env |
				              result2 := env at: 'y' ]) }.
	generator value: {
			('x' -> 1).
			('y' -> 2) } asDictionary.
	self assert: result1 equals: 1.
	self assert: result2 equals: 2
]
