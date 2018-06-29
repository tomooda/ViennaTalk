Class {
	#name : #ViennaTotalFunctionTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'bool',
		'nat',
		'nat1',
		'int'
	],
	#category : 'ViennaTalk-Type-Tests'
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
ViennaTotalFunctionTypeTest >> testSubset [
	self assert: nat * nat -> nat <= (nat * nat -> nat).
	self assert: int * nat -> nat <= (nat * nat -> nat).
	self assert: nat * nat -> nat <= (nat * nat -> int).
	self assert: nat * nat +> nat <= (nat * nat -> nat).
	self assert: int * nat +> nat <= (nat * nat -> nat).
	self assert: nat * nat +> nat <= (nat * nat -> int).
	self deny: nat * nat -> nat <= (nat * nat +> nat).
	self deny: int * nat -> nat <= (nat * nat +> nat).
	self deny: nat * nat -> nat <= (nat * nat +> int)
]
