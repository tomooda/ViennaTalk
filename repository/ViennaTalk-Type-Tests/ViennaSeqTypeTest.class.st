Class {
	#name : #ViennaSeqTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'seqofnat'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaSeqTypeTest >> setUp [
	super setUp.
	seqofnat := ViennaSeqType with: ViennaType nat
]

{ #category : #tests }
ViennaSeqTypeTest >> testAmpersand [

	| nat real char unit |
	nat := ViennaType nat.
	real := ViennaType real.
	char := ViennaType char.
	unit := ViennaType unit.
	self assert: nat seq & nat seq equals: nat seq.
	self assert: real seq & nat seq1 equals: nat seq1.
	self assert: nat seq & char seq equals: unit seq
]

{ #category : #tests }
ViennaSeqTypeTest >> testDo [
	self should: [ seqofnat do: [ :i |  ] ] raise: ShouldNotImplement
]

{ #category : #tests }
ViennaSeqTypeTest >> testIncludes [
	self assert: (seqofnat includes: #() asOrderedCollection).
	self assert: (seqofnat includes: #(1) asOrderedCollection).
	self deny: (seqofnat includes: #(1 2.3) asOrderedCollection)
]

{ #category : #tests }
ViennaSeqTypeTest >> testIsCompatibleWith [

	self assert:
		(ViennaType char seq isCompatibleWith: ViennaType char seq).
	self assert:
		(ViennaType char seq isCompatibleWith: ViennaType char seq1).
	self deny: (ViennaType char seq isCompatibleWith: ViennaType char).
	self deny: (ViennaType char seq isCompatibleWith: ViennaType nat seq).
	self deny:
		(ViennaType char seq isCompatibleWith: ViennaType char set)
]

{ #category : #tests }
ViennaSeqTypeTest >> testIsEnumerable [
	self deny: seqofnat isEnumerable.
	self deny: (ViennaSeqType with: ViennaType bool) isEnumerable
]

{ #category : #tests }
ViennaSeqTypeTest >> testName [
	self assert: seqofnat name equals: 'seq of nat'.
	self assert: (ViennaSeqType with: ViennaType nat | ViennaType bool) name equals: 'seq of (nat|bool)'
]

{ #category : #tests }
ViennaSeqTypeTest >> testPlus [

	| nat nat1 char |
	nat := ViennaType nat.
	nat1 := ViennaType nat1.
	char := ViennaType char.
	self assert: nat seq + nat seq equals: nat seq.
	self assert: nat seq + nat1 seq equals: nat seq.
	self assert: nat1 seq + nat seq equals: nat seq.
	self assert: nat seq + char seq equals: nat seq | char seq.
	self assert: nat seq + nat seq1 equals: nat seq
]

{ #category : #tests }
ViennaSeqTypeTest >> testRemoveTypeHolders [
	self
		assert: ViennaType nat asTypeHolder seq removeTypeHolders
		equals: ViennaType nat seq
]

{ #category : #tests }
ViennaSeqTypeTest >> testSubtype [
	self assert: seqofnat <= seqofnat.
	self assert: seqofnat <= (ViennaType seqOf: ViennaType nat | ViennaType bool).
	self deny: (ViennaType seqOf: ViennaType bool | ViennaType nat) <= seqofnat
]
