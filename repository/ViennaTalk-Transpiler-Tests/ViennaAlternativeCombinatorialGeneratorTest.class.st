Class {
	#name : 'ViennaAlternativeCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaAlternativeCombinatorialGeneratorTest >> testNext [

	| generator set |
	set := Set new.
	generator := ViennaAlternativeCombinatorialGenerator withAll: {
			             (ViennaSequentialCombinatorialGenerator withAll: {
					              (ViennaCallCombinatorialGenerator on: [ :env |
						               set add: (env at: 'x') ]).
					              (ViennaCallCombinatorialGenerator on: [ :env |
						               set add: (env at: 'y') ]) }).
			             (ViennaCallCombinatorialGenerator on: [ :env |
				              set add: (env at: 'z') ]) }.
	generator next value: {
			('x' -> 1).
			('y' -> 2).
			('z' -> 3) } asDictionary.
	self assert: set equals: { 1. 2 } asSet.
	set removeAll.
	generator next value: {
			('x' -> 1).
			('y' -> 2).
			('z' -> 3) } asDictionary.
	self assert: set equals: { 3 } asSet.
	self assert: generator peek isNil
]

{ #category : 'tests' }
ViennaAlternativeCombinatorialGeneratorTest >> testPeek [

	| generator set |
	set := Set new.
	generator := ViennaAlternativeCombinatorialGenerator withAll: {
			             (ViennaCallCombinatorialGenerator on: [ :env |
				              set add: (env at: 'x') ]).
			             (ViennaCallCombinatorialGenerator on: [ :env |
				              set add: (env at: 'y') ]) }.
	self deny: generator peek isNil.
	generator peek value: {
			('x' -> 1).
			('y' -> 2) } asDictionary.
	generator step.
	generator peek value: {
			('x' -> 1).
			('y' -> 2) } asDictionary.
	generator step.
	self assert: generator peek isNil.
	self assert: set equals: { 1. 2 } asSet
]

{ #category : 'tests' }
ViennaAlternativeCombinatorialGeneratorTest >> testStep [

	| generator |
	generator := ViennaAlternativeCombinatorialGenerator withAll: {
			             (ViennaCallCombinatorialGenerator on: [ :env |  ]).
			             (ViennaCallCombinatorialGenerator on: [ :env |  ]) }.
	self deny: generator peek isNil.
	generator step.
	self deny: generator peek isNil.
	generator step.
	self assert: generator peek isNil
]
