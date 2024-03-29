Class {
	#name : #ViennaSeq1TypeTest,
	#superclass : #TestCase,
	#instVars : [
		'seq1ofnat'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaSeq1TypeTest >> setUp [
	super setUp.
	seq1ofnat := ViennaSeq1Type with: ViennaType nat
]

{ #category : #tests }
ViennaSeq1TypeTest >> testAmpersand [

	| nat real char unit |
	nat := ViennaType nat.
	real := ViennaType real.
	char := ViennaType char.
	unit := ViennaType unit.
	self assert: nat seq1 & nat seq1 equals: nat seq1.
	self assert: real seq1 & nat seq equals: nat seq1.
	self assert: nat seq1 & char seq equals: unit
]

{ #category : #tests }
ViennaSeq1TypeTest >> testDo [
	self should: [ seq1ofnat do: [ :i |  ] ] raise: ShouldNotImplement
]

{ #category : #tests }
ViennaSeq1TypeTest >> testIncludes [
	self deny: (seq1ofnat includes: #() asOrderedCollection).
	self assert: (seq1ofnat includes: #(1) asOrderedCollection).
	self deny: (seq1ofnat includes: #(1 2.3) asOrderedCollection)
]

{ #category : #tests }
ViennaSeq1TypeTest >> testIsCompatibleWith [

	self assert:
		(ViennaType char seq1 isCompatibleWith: ViennaType char seq1).
	self assert:
		(ViennaType char seq1 isCompatibleWith: ViennaType char seq).
	self deny: (ViennaType char seq1 isCompatibleWith: ViennaType char).
	self deny:
		(ViennaType char seq1 isCompatibleWith: ViennaType nat seq1).
	self deny:
		(ViennaType char seq1 isCompatibleWith: ViennaType char set)
]

{ #category : #tests }
ViennaSeq1TypeTest >> testIsEnumerable [
	self deny: seq1ofnat isEnumerable.
	self deny: (ViennaSeq1Type with: ViennaType bool) isEnumerable
]

{ #category : #tests }
ViennaSeq1TypeTest >> testName [
	self assert: seq1ofnat name equals: 'seq1 of nat'.
	self assert: (ViennaSeq1Type with: ViennaType nat | ViennaType bool) name equals: 'seq1 of (nat|bool)'
]

{ #category : #tests }
ViennaSeq1TypeTest >> testPlus [

	| nat nat1 char |
	nat := ViennaType nat.
	nat1 := ViennaType nat1.
	char := ViennaType char.
	self assert: nat seq1 + nat seq1 equals: nat seq1.
	self assert: nat seq1 + nat1 seq1 equals: nat seq1.
	self assert: nat1 seq1 + nat seq1 equals: nat seq1.
	self assert: nat seq1 + char seq1 equals: nat seq1 | char seq1.
	self assert: nat seq1 + nat seq equals: nat seq
]

{ #category : #tests }
ViennaSeq1TypeTest >> testRemoveTypeHolders [
	self
		assert: ViennaType nat asTypeHolder seq1 removeTypeHolders
		equals: ViennaType nat seq1
]

{ #category : #tests }
ViennaSeq1TypeTest >> testSubtype [
	self assert: seq1ofnat <= seq1ofnat.
	self assert: seq1ofnat < (ViennaType seqOf: ViennaType nat).
	self assert: seq1ofnat <= (ViennaType seqOf: ViennaType nat).
	self deny: (ViennaType seqOf: ViennaType nat) <= seq1ofnat
]
