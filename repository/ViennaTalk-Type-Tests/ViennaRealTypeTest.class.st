Class {
	#name : #ViennaRealTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'real'
	],
	#category : 'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaRealTypeTest >> setUp [
	super setUp.
	real := ViennaRealType current
]

{ #category : #tests }
ViennaRealTypeTest >> testDo [
	self should: [ real do: [ :i |  ] ] raise: ShouldNotImplement
]

{ #category : #tests }
ViennaRealTypeTest >> testIncludes [
	self assert: (real includes: -1).
	self assert: (real includes: 0).
	self assert: (real includes: 1).
	self assert: (real includes: 1.23).
	self deny: (real includes: $a)
]

{ #category : #tests }
ViennaRealTypeTest >> testIsEnumerable [
	self deny: real isEnumerable
]

{ #category : #tests }
ViennaRealTypeTest >> testName [
	self assert: real name equals: 'real'
]

{ #category : #tests }
ViennaRealTypeTest >> testSubset [
	self assert: real <= real.
	self deny: real < ViennaType int.
	self deny: real < ViennaType nat.
	self deny: real < ViennaType nat1
]
