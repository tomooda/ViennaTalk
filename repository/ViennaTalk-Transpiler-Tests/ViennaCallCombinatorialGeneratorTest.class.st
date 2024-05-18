Class {
	#name : 'ViennaCallCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaCallCombinatorialGeneratorTest >> testNext [

	| generator |
	generator := ViennaCallCombinatorialGenerator on: [ :env |
		             env at: 'x' ].
	self deny: generator peek isNil.
	self
		assert: (generator next value: { ('x' -> 1) } asDictionary)
		equals: 1.
	self assert: generator next isNil
]

{ #category : 'tests' }
ViennaCallCombinatorialGeneratorTest >> testPeek [

	| generator |
	generator := ViennaCallCombinatorialGenerator on: [ :env |
		             env at: 'x' ].
	self deny: generator peek isNil.
	self
		assert: (generator peek value: { ('x' -> 1) } asDictionary)
		equals: 1.
	generator step.
	self assert: generator peek isNil
]

{ #category : 'tests' }
ViennaCallCombinatorialGeneratorTest >> testStep [

	| generator |
	generator := ViennaCallCombinatorialGenerator on: [ :env |
		             env at: 'x' ].
	self deny: generator peek isNil.
	generator step.
	self assert: generator peek isNil
]
