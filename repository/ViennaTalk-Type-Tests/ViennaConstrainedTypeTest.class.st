Class {
	#name : #ViennaConstrainedTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'int',
		'bool'
	],
	#category : 'ViennaTalk-Type-Tests'
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
ViennaConstrainedTypeTest >> testIsEnumerable [
	self deny: (int inv: [ :i | i < 0 ]) isEnumerable.
	self assert: (bool inv: [ :b | b ]) isEnumerable
]

{ #category : #tests }
ViennaConstrainedTypeTest >> testName [
	self assert: (int inv: [ :i | i < 0 ]) name equals: 'int inv [ :i | i < 0 ]'
]

{ #category : #tests }
ViennaConstrainedTypeTest >> testSubtype [
	self assert: (int inv: [ :i | i < 0 ]) <= int.
	self deny: int <= (int inv: [ :i | i < 0 ]).
	self deny: (int inv: [ :i | i > 1 ]) <= (int inv: [ :i | i > 0 ])
]
