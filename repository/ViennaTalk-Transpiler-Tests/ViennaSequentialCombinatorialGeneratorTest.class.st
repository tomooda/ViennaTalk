Class {
	#name : 'ViennaSequentialCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaSequentialCombinatorialGeneratorTest >> testNext [

	| generator result1 result2 |
	generator := ViennaSequentialCombinatorialGenerator withAll: {
			             (ViennaBlockCombinatorialGenerator on: [ :env |
				              result1 := env at: 'x' ]).
			             (ViennaBlockCombinatorialGenerator on: [ :env |
				              result2 := env at: 'y' ]) }.
	self deny: (generator next: {
				 ('x' -> 1).
				 ('y' -> 2) } asDictionary).
	self assert: result1 equals: 1.
	self assert: result2 equals: 2
]

{ #category : 'tests' }
ViennaSequentialCombinatorialGeneratorTest >> testStep [

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
ViennaSequentialCombinatorialGeneratorTest >> testValue [

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
