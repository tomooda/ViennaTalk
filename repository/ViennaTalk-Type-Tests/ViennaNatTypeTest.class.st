Class {
	#name : #ViennaNatTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'nat'
	],
	#category : 'ViennaTalk-Type-Tests'
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
ViennaNatTypeTest >> testIsEnumerable [
	self deny: nat isEnumerable
]

{ #category : #tests }
ViennaNatTypeTest >> testName [
	self assert: nat name equals: 'nat'
]

{ #category : #tests }
ViennaNatTypeTest >> testSubtype [
	self assert: nat <= nat.
	self assert: nat <= ViennaType int
]
