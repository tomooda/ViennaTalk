Class {
	#name : #ViennaNatTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'nat'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaNatTypeTest >> setUp [

	super setUp.
	nat := ViennaNatType current
]

{ #category : #tests }
ViennaNatTypeTest >> testDo [
	self should: [ nat do: [ :i |  ] ] raise: ShouldNotImplement
]

{ #category : #tests }
ViennaNatTypeTest >> testIncludes [
	self deny: (nat includes: -1).
	self assert: (nat includes: 0).
	self assert: (nat includes: 1).
	self deny: (nat includes: 1.23).
	self deny: (nat includes: $a)
]

{ #category : #tests }
ViennaNatTypeTest >> testIsCompatibleWith [

	self assert: (nat isCompatibleWith: nat).
	self assert: (nat isCompatibleWith: ViennaType nat1).
	self assert: (nat isCompatibleWith: ViennaType real).
	self deny: (nat isCompatibleWith: ViennaType char)
]

{ #category : #tests }
ViennaNatTypeTest >> testIsEnumerable [
	self deny: nat isEnumerable
]

{ #category : #tests }
ViennaNatTypeTest >> testName [
	self assert: nat name equals: 'nat'
]

{ #category : #tests }
ViennaNatTypeTest >> testPlus [

	self assert: nat + nat equals: nat.
	self assert: nat + ViennaType nat1 equals: nat.
	self assert: nat + ViennaType real equals: ViennaType real.
	self assert: nat + ViennaType char equals: nat | ViennaType char
]

{ #category : #tests }
ViennaNatTypeTest >> testRemoveTypeHolders [
	self assert: nat asTypeHolder removeTypeHolders equals: nat
]

{ #category : #tests }
ViennaNatTypeTest >> testSubtype [
	self assert: nat <= nat.
	self assert: nat <= ViennaType int
]
