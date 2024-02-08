Class {
	#name : #ViennaTotalFunctionTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'bool',
		'nat',
		'nat1',
		'int'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaTotalFunctionTypeTest >> setUp [
	super setUp.
	bool := ViennaType bool.
	int := ViennaType int.
	nat := ViennaType nat.
	nat1 := ViennaType nat1
]

{ #category : #tests }
ViennaTotalFunctionTypeTest >> testAmpersand [

	| real char unit |
	real := ViennaType real.
	char := ViennaType char.
	unit := ViennaType unit.
	self
		assert: nat * nat +> nat & (nat * nat +> nat)
		equals: nat * nat +> nat.
	self assert: unit +> nat & (unit +> nat) equals: unit +> nat.
	self
		assert: nat * real +> nat & (real * nat -> nat optional)
		equals: nat * nat -> nat.
	self assert: nat * char +> nat & (nat * nat +> nat) equals: unit.
	self assert: nat * nat +> char & (nat * nat +> nat) equals: unit.
	self
		assert: nat * nat +> char & (nat * nat * nat +> char)
		equals: unit
]

{ #category : #tests }
ViennaTotalFunctionTypeTest >> testDo [
	self should: [ bool +> bool do: [ :f |  ] ] raise: ShouldNotImplement
]

{ #category : #tests }
ViennaTotalFunctionTypeTest >> testIncludes [
	self assert: (bool +> bool includes: [ :b | b not ]).
	self deny: (bool +> bool includes: [ :b1 :b2 | b1 and: [ b2 ] ]).
	self
		deny:
			(bool +> bool
				includes:
					(Dictionary new
						at: true put: false;
						at: false put: true;
						yourself)).
	self assert: (bool +> bool includes: [ :n | n + 1 ])
]

{ #category : #tests }
ViennaTotalFunctionTypeTest >> testIsCompatibleWith [

	self assert: (nat * int +> bool isCompatibleWith: nat * int +> bool).
	self assert: (nat * int +> bool isCompatibleWith: int * nat +> bool).
	self assert: (nat * int +> bool isCompatibleWith: nat * int -> bool).
	self deny: (nat * int +> bool isCompatibleWith: bool * int +> bool).
	self deny: (nat * int +> bool isCompatibleWith: nat * int +> int)
]

{ #category : #tests }
ViennaTotalFunctionTypeTest >> testIsEnumerable [
	self deny: (bool +> bool) isEnumerable.
	self deny: (nat +> nat) isEnumerable
]

{ #category : #tests }
ViennaTotalFunctionTypeTest >> testName [
	self assert: (nat * int +> bool) name equals: 'nat*int+>bool'.
	self assert: ((nat | bool) * int +> bool) name equals: '(nat|bool)*int+>bool'.
	self assert: (int -> nat +> nat1) name equals: '(int->nat)+>nat1'.
	self assert: (int -> (nat +> nat1)) name equals: 'int->nat+>nat1'
]

{ #category : #tests }
ViennaTotalFunctionTypeTest >> testPlus [

	self assert: nat +> nat + (nat +> nat) equals: nat +> nat.
	self assert: nat +> nat + (nat1 +> nat) equals: nat +> nat.
	self assert: nat +> nat + (nat +> nat1) equals: nat +> nat
]

{ #category : #tests }
ViennaTotalFunctionTypeTest >> testRemoveTypeHolders [
	self
		assert: (ViennaType nat asTypeHolder +> ViennaType int asTypeHolder) removeTypeHolders
		equals: ViennaType nat +> ViennaType int
]

{ #category : #tests }
ViennaTotalFunctionTypeTest >> testSubtype [
	self assert: nat * nat -> nat <= (nat * nat -> nat).
	self assert: nat * nat -> nat <= (int * nat -> nat).
	self assert: nat * nat -> nat <= (nat * nat -> int).
	self assert: nat * nat +> nat <= (nat * nat -> nat).
	self assert: nat * nat +> nat <= (int * nat -> nat).
	self assert: nat * nat +> nat <= (nat * nat -> int).
	self deny: nat * nat -> nat <= (nat * nat +> nat).
	self deny: nat * nat -> nat <= (int * nat +> nat).
	self deny: nat * nat -> nat <= (nat * nat +> int)
]
