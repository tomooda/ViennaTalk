Class {
	#name : #ViennaTypeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #tests }
ViennaTypeTest >> testAmpersand [

	| nat real char unit |
	nat := ViennaType nat.
	real := ViennaType real.
	char := ViennaType char.
	unit := ViennaType unit.
	self assert: nat & char equals: unit.
	self assert: nat & real equals: nat.
	self assert: real & nat equals: nat.
	self assert: nat | char & char equals: char.
	self assert: nat | char optional & nat optional equals: nat optional.
	self assert: char optional & nat optional equals: unit optional.
	self assert: char set & nat set equals: unit set
]

{ #category : #tests }
ViennaTypeTest >> testAsTypeHolder [
	self assert: ViennaType nat asTypeHolder type equals: ViennaType nat
]
