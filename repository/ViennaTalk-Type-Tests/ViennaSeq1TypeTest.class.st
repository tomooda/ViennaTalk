Class {
	#name : #ViennaSeq1TypeTest,
	#superclass : #TestCase,
	#instVars : [
		'seq1ofnat'
	],
	#category : 'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaSeq1TypeTest >> setUp [
	super setUp.
	seq1ofnat := ViennaSeq1Type with: ViennaType nat
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
ViennaSeq1TypeTest >> testSubtype [
	self assert: seq1ofnat <= seq1ofnat.
	self assert: seq1ofnat < (ViennaType seqOf: ViennaType nat).
	self assert: seq1ofnat <= (ViennaType seqOf: ViennaType nat).
	self deny: (ViennaType seqOf: ViennaType nat) <= seq1ofnat
]
