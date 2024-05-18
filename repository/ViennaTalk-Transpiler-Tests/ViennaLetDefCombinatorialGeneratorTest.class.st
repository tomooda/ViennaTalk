Class {
	#name : 'ViennaLetDefCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaLetDefCombinatorialGeneratorTest >> testNext [

	| generator |
	generator := ViennaLetDefCombinatorialGenerator
		             on: [ :env | env at: 'x' put: 1 ]
		             in:
		             (ViennaCallCombinatorialGenerator on: [ :env |
			              env at: 'x' ]).
	self deny: generator peek isNil.
	self assert: (generator next value: {  } asDictionary) equals: 1.
	self assert: generator next isNil
]

{ #category : 'tests' }
ViennaLetDefCombinatorialGeneratorTest >> testPeek [

	| generator |
	generator := ViennaLetDefCombinatorialGenerator
		             on: [ :env | env at: 'x' put: 1 ]
		             in:
		             (ViennaCallCombinatorialGenerator on: [ :env |
			              env at: 'x' ]).
	self deny: generator peek isNil.
	self assert: (generator peek value: {  } asDictionary) equals: 1.
	generator step.
	self assert: generator peek isNil
]

{ #category : 'tests' }
ViennaLetDefCombinatorialGeneratorTest >> testStep [

	| generator |
	generator := ViennaLetDefCombinatorialGenerator
		             on: [ :env | env at: 'x' put: 1 ]
		             in:
		             (ViennaCallCombinatorialGenerator on: [ :env |
			              env at: 'x' ]).
	self deny: generator peek isNil.
	generator step.
	self assert: generator peek isNil
]
