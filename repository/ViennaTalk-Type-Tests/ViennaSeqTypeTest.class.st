Class {
	#name : #ViennaSeqTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'seqofnat'
	],
	#category : 'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaSeqTypeTest >> setUp [
	super setUp.
	seqofnat := ViennaSeqType with: ViennaType nat
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
ViennaSeqTypeTest >> testSubtype [
	self assert: seqofnat <= seqofnat.
	self assert: seqofnat <= (ViennaType seqOf: ViennaType nat | ViennaType bool).
	self deny: (ViennaType seqOf: ViennaType bool | ViennaType nat) <= seqofnat
]
