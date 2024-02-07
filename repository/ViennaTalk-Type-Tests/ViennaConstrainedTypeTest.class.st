Class {
	#name : #ViennaConstrainedTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'int',
		'bool'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaConstrainedTypeTest >> setUp [
	super setUp.
	int := ViennaType int.
	bool := ViennaType bool
]

{ #category : #tests }
ViennaConstrainedTypeTest >> testDo [
	self should: [ (int inv: [ :i | i < 0 ]) do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | (bool inv: [ :b | b ]) do: [ :b | stream nextPut: b ] ])
		equals: #(true)
]

{ #category : #tests }
ViennaConstrainedTypeTest >> testIncludes [
	self assert: ((int inv: [ :i | i < 0 ]) includes: -1).
	self deny: ((int inv: [ :i | i < 0 ]) includes: 1)
]

{ #category : #tests }
ViennaConstrainedTypeTest >> testIsCompatibleWith [

	self assert:
		((int inv: [ :i | i odd ]) isCompatibleWith:
			 (int inv: [ :i | i odd ])).
	self assert: ((int inv: [ :i | i odd ]) isCompatibleWith:
			 (int inv: [ :i | i even ])).
	self assert: ((int inv: [ :i | i odd ]) isCompatibleWith: int).
	self assert: (int isCompatibleWith: (int inv: [ :i | i odd ])).
	self assert: ((int inv: [ :i | i odd ]) isCompatibleWith:
			 (ViennaType nat inv: [ :i | i odd ])).
	self deny: ((int inv: [ :i | i odd ]) isCompatibleWith: bool)
]

{ #category : #tests }
ViennaConstrainedTypeTest >> testIsEnumerable [
	self deny: (int inv: [ :i | i < 0 ]) isEnumerable.
	self assert: (bool inv: [ :b | b ]) isEnumerable
]

{ #category : #tests }
ViennaConstrainedTypeTest >> testName [
	self assert: (int inv: [ :i | i < 0 ]) name equals: 'int inv [ :i | i < 0 ]'
]

{ #category : #tests }
ViennaConstrainedTypeTest >> testPlus [

	self assert: (int inv: #odd) + int equals: int.
	self
		assert: (int inv: #odd) + (int inv: #even)
		equals: (int inv: #odd) | (int inv: #even)
]

{ #category : #tests }
ViennaConstrainedTypeTest >> testRemoveTypeHolders [
	| inv |
	inv := [ :i | true ].
	self assert: (int asTypeHolder inv: inv) removeTypeHolders equals: (int inv: inv)
]

{ #category : #tests }
ViennaConstrainedTypeTest >> testSubtype [
	self assert: (int inv: [ :i | i < 0 ]) <= int.
	self deny: int <= (int inv: [ :i | i < 0 ]).
	self deny: (int inv: [ :i | i > 1 ]) <= (int inv: [ :i | i > 0 ])
]
