Class {
	#name : #ViennaOperationTypeTest,
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
ViennaOperationTypeTest >> setUp [
	super setUp.
	bool := ViennaType bool.
	int := ViennaType int.
	nat := ViennaType nat.
	nat1 := ViennaType nat1
]

{ #category : #tests }
ViennaOperationTypeTest >> testDo [
	self should: [ bool ==> bool do: [ :f |  ] ] raise: ShouldNotImplement
]

{ #category : #tests }
ViennaOperationTypeTest >> testIncludes [

	self deny: (bool ==> bool includes: [ :b | b not ]).
	self deny: (bool ==> bool includes: [ :b1 :b2 | b1 and: [ b2 ] ]).
	self deny: (bool ==> bool includes: (Dictionary new
				  at: true put: false;
				  at: false put: true;
				  yourself)).
	self deny: (bool ==> bool includes: [ :n | n + 1 ])
]

{ #category : #tests }
ViennaOperationTypeTest >> testIsCompatibleWith [

	self assert:
		(nat * int ==> bool isCompatibleWith: nat * int ==> bool).
	self assert:
		(nat * int ==> bool isCompatibleWith: int * nat ==> bool).
	self deny: (nat * int ==> bool isCompatibleWith: bool * int ==> bool).
	self deny: (nat * int ==> bool isCompatibleWith: nat * int ==> int)
]

{ #category : #tests }
ViennaOperationTypeTest >> testIsEnumerable [
	self deny: (bool ==> bool) isEnumerable.
	self deny: (nat ==> nat) isEnumerable
]

{ #category : #tests }
ViennaOperationTypeTest >> testName [
	self assert: (nat * int ==> bool) name equals: 'nat*int==>bool'.
	self assert: ((nat | bool) * int ==> bool) name equals: '(nat|bool)*int==>bool'.
	self assert: (int -> nat ==> nat1) name equals: '(int->nat)==>nat1'.
	self assert: (int ==> (nat -> nat1)) name equals: 'int==>nat->nat1'
]

{ #category : #tests }
ViennaOperationTypeTest >> testPlus [

	self assert: nat ==> nat + (nat ==> nat) equals: nat ==> nat.
	self assert: nat ==> nat + (nat1 ==> nat) equals: nat ==> nat.
	self assert: nat ==> nat + (nat ==> nat1) equals: nat ==> nat
]

{ #category : #tests }
ViennaOperationTypeTest >> testRemoveTypeHolders [
	self
		assert: (ViennaType nat asTypeHolder ==> ViennaType int asTypeHolder) removeTypeHolders
		equals: ViennaType nat ==> ViennaType int
]

{ #category : #tests }
ViennaOperationTypeTest >> testSubtype [
	self assert: nat * nat ==> nat <= (nat * nat ==> nat).
	self assert: nat * nat ==> nat <= (int * nat ==> nat).
	self assert: nat * nat ==> nat <= (nat * nat ==> int)
]
