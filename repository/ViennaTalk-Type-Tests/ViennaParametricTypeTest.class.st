Class {
	#name : #ViennaParametricTypeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #tests }
ViennaParametricTypeTest >> testAmpersand [

	| nat real char unit |
	nat := ViennaType nat.
	real := ViennaType real.
	char := ViennaType char.
	unit := ViennaType unit.
	self
		assert: nat * nat -> nat & (nat * nat -> nat)
		equals: nat * nat -> nat.
	self
		assert: nat * real -> nat & (real * nat -> nat optional)
		equals: nat * nat -> nat.
	self assert: nat * char -> nat & (nat * nat -> nat) equals: unit.
	self assert: nat * nat -> char & (nat * nat -> nat) equals: unit.
	self
		assert: nat * nat -> char & (nat * nat * nat -> char)
		equals: unit
]

{ #category : #tests }
ViennaParametricTypeTest >> testIsCompatibleWith [

	| t1 t2 |
	t1 := ViennaType parametric: '@t1'.
	t2 := ViennaType parametric: '@t2'.
	self assert: (t1 isCompatibleWith: t1).
	self assert: (t2 isCompatibleWith: t2).
	self deny: (t1 isCompatibleWith: t2).
	self assert: (t1 isCompatibleWith: ViennaType any).
	self deny: (t1 isCompatibleWith: ViennaType nat)
]

{ #category : #tests }
ViennaParametricTypeTest >> testPlus [

	| t1 t2 |
	t1 := ViennaType parametric: '@t1'.
	t2 := ViennaType parametric: '@t2'.
	self assert: t1 + t1 equals: t1.
	self assert: t1 + t2 equals: t1 | t2.
	self assert: t1 + ViennaType any equals: ViennaType any
]
