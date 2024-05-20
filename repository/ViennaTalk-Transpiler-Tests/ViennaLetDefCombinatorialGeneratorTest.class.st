Class {
	#name : 'ViennaLetDefCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaLetDefCombinatorialGeneratorTest >> testNext [

	| generator result |
	generator := ViennaLetDefCombinatorialGenerator
		             bindBlock: [ :env | env at: 'x' put: 1 ]
		             in:
		             (ViennaBlockCombinatorialGenerator on: [ :env |
			              result := env at: 'x' ]).
	result := nil.
	self deny: (generator next: {  } asDictionary).
	self assert: result equals: 1
]

{ #category : 'tests' }
ViennaLetDefCombinatorialGeneratorTest >> testStep [

	| generator result |
	generator := ViennaLetDefCombinatorialGenerator
		             bindBlock: [ :env | env at: 'x' put: 1 ]
		             in:
		             (ViennaBlockCombinatorialGenerator on: [ :env |
			              result := env at: 'x' ]).
	result := nil.
	self deny: (generator step: Dictionary new)
]

{ #category : 'tests' }
ViennaLetDefCombinatorialGeneratorTest >> testValue [

	| generator result |
	generator := ViennaLetDefCombinatorialGenerator
		             bindBlock: [ :env | env at: 'x' put: 1 ]
		             in:
		             (ViennaBlockCombinatorialGenerator on: [ :env |
			              result := env at: 'x' ]).
	result := nil.
	self assert: (generator value: {  } asDictionary) notNil.
	self assert: result equals: 1
]
