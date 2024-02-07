Class {
	#name : #ViennaIntTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'int'
	],
	#category : #'ViennaTalk-Type-Tests'
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
ViennaIntTypeTest >> testIsCompatibleWith [

	self assert: (int isCompatibleWith: int).
	self assert: (int isCompatibleWith: ViennaType nat).
	self assert: (int isCompatibleWith: ViennaType real).
	self deny: (int isCompatibleWith: ViennaType char)
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
ViennaIntTypeTest >> testPlus [

	self assert: int + int equals: int.
	self assert: int + ViennaType nat equals: int.
	self assert: int + ViennaType real equals: ViennaType real.
	self assert: int + ViennaType char equals: int | ViennaType char
]

{ #category : #tests }
ViennaIntTypeTest >> testRemoveTypeHolders [
	self assert: int asTypeHolder removeTypeHolders equals: int
]

{ #category : #tests }
ViennaIntTypeTest >> testSubtype [
	self assert: int <= int.
	self assert: int <= ViennaType real.
	self deny: int <= ViennaType nat
]
