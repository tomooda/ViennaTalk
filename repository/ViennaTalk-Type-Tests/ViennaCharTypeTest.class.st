Class {
	#name : #ViennaCharTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'char'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaCharTypeTest >> setUp [
	super setUp.
	char := ViennaCharType current
]

{ #category : #tests }
ViennaCharTypeTest >> testDo [
	self should: [ char do: [ :i |  ] ] raise: ShouldNotImplement
]

{ #category : #tests }
ViennaCharTypeTest >> testIncludes [
	self deny: (char includes: 1.23).
	self assert: (char includes: $a)
]

{ #category : #tests }
ViennaCharTypeTest >> testIsCompatibleWith [

	self assert: (char isCompatibleWith: char).
	self deny: (char isCompatibleWith: ViennaType nat)
]

{ #category : #tests }
ViennaCharTypeTest >> testIsEnumerable [
	self deny: char isEnumerable
]

{ #category : #tests }
ViennaCharTypeTest >> testName [
	self assert: char name equals: 'char'
]

{ #category : #tests }
ViennaCharTypeTest >> testRemoveTestHolders [
	self assert: char removeTypeHolders equals: char
]

{ #category : #tests }
ViennaCharTypeTest >> testSubtype [
	self assert: char <= char.
	self deny: char <= ViennaType int
]
