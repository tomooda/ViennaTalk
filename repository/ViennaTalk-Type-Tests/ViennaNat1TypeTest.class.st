Class {
	#name : #ViennaNat1TypeTest,
	#superclass : #TestCase,
	#instVars : [
		'nat1'
	],
	#category : 'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaNat1TypeTest >> setUp [
	super setUp.
	nat1 := ViennaNat1Type current
]

{ #category : #tests }
ViennaNat1TypeTest >> testDo [
	self should: [ nat1 do: [ :i |  ] ] raise: ShouldNotImplement
]

{ #category : #tests }
ViennaNat1TypeTest >> testIncludes [
	self deny: (nat1 includes: -1).
	self deny: (nat1 includes: 0).
	self assert: (nat1 includes: 1).
	self deny: (nat1 includes: 1.23).
	self deny: (nat1 includes: $a)
]

{ #category : #tests }
ViennaNat1TypeTest >> testIsEnumerable [
	self deny: nat1 isEnumerable
]

{ #category : #tests }
ViennaNat1TypeTest >> testName [
	self assert: nat1 name equals: 'nat1'
]

{ #category : #tests }
ViennaNat1TypeTest >> testSubtype [
	self assert: nat1 <= nat1.
	self assert: nat1 <= ViennaType nat
]
