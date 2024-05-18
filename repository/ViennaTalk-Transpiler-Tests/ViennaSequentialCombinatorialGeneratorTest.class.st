Class {
	#name : 'ViennaSequentialCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaSequentialCombinatorialGeneratorTest >> testNext [

	| generator set sets |
	sets := Set new.
	set := Set new.
	generator := ViennaSequentialCombinatorialGenerator withAll: {
			             (ViennaAlternativeCombinatorialGenerator withAll: {
					              (ViennaCallCombinatorialGenerator on: [ :env |
						               set add: (env at: 'w') ]).
					              (ViennaCallCombinatorialGenerator on: [ :env |
						               set add: (env at: 'x') ]) }).
			             (ViennaAlternativeCombinatorialGenerator withAll: {
					              (ViennaCallCombinatorialGenerator on: [ :env |
						               set add: (env at: 'y') ]).
					              (ViennaCallCombinatorialGenerator on: [ :env |
						               set add: (env at: 'z') ]) }) }.
	generator next value: {
			('w' -> 0).
			('x' -> 1).
			('y' -> 2).
			('z' -> 3) } asDictionary.
	sets add: set.
	set := Set new.
	generator next value: {
			('w' -> 0).
			('x' -> 1).
			('y' -> 2).
			('z' -> 3) } asDictionary.
	sets add: set.
	set := Set new.
	generator next value: {
			('w' -> 0).
			('x' -> 1).
			('y' -> 2).
			('z' -> 3) } asDictionary.
	sets add: set.
	set := Set new.
	generator next value: {
			('w' -> 0).
			('x' -> 1).
			('y' -> 2).
			('z' -> 3) } asDictionary.
	sets add: set.
	self assert: generator peek isNil.
	self assert: sets equals: {
			{ 0. 2 } asSet.
			{ 0. 3 } asSet.
			{ 1. 2 } asSet.
			{ 1. 3 } asSet } asSet
]

{ #category : 'tests' }
ViennaSequentialCombinatorialGeneratorTest >> testPeek [

	| generator set |
	set := Set new.
	generator := ViennaSequentialCombinatorialGenerator withAll: {
			             (ViennaCallCombinatorialGenerator on: [ :env |
				              set add: (env at: 'x') ]).
			             (ViennaCallCombinatorialGenerator on: [ :env |
				              set add: (env at: 'y') ]) }.
	self deny: generator peek isNil.
	generator peek value: {
			('x' -> 1).
			('y' -> 2) } asDictionary.
	generator step.
	self assert: generator peek isNil.
	self assert: set equals: { 1. 2 } asSet
]

{ #category : 'tests' }
ViennaSequentialCombinatorialGeneratorTest >> testStep [

	| generator |
	generator := ViennaSequentialCombinatorialGenerator withAll: {
			             (ViennaCallCombinatorialGenerator on: [ :env |  ]).
			             (ViennaCallCombinatorialGenerator on: [ :env |  ]) }.
	self deny: generator peek isNil.
	generator step.
	self assert: generator peek isNil
]
