Class {
	#name : #ViennaIntTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'int'
	],
	#category : 'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaIntTypeTest >> setUp [
	super setUp.
	int := ViennaIntType current
]

{ #category : #tests }
ViennaIntTypeTest >> testDo [
	self should: [ int do: [ :i |  ] ] raise: ShouldNotImplement
]

{ #category : #tests }
ViennaIntTypeTest >> testIncludes [
	self assert: (int includes: -1).
	self assert: (int includes: 0).
	self assert: (int includes: 1).
	self deny: (int includes: 1.23).
	self deny: (int includes: $a)
]

{ #category : #tests }
ViennaIntTypeTest >> testIsEnumerable [
	self deny: int isEnumerable
]

{ #category : #tests }
ViennaIntTypeTest >> testName [
	self assert: int name equals: 'int'
]

{ #category : #tests }
ViennaIntTypeTest >> testSubtype [
	self assert: int <= int.
	self assert: int <= ViennaType real.
	self deny: int <= ViennaType nat
]
