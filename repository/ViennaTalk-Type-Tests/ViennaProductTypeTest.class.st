Class {
	#name : #ViennaProductTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'natBool',
		'quoteBool'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaProductTypeTest >> setUp [
	super setUp.
	natBool := ViennaProductType with: ViennaType nat with: ViennaType bool.
	quoteBool := ViennaProductType with: (ViennaType quote: #QUOTE) with: ViennaType bool
]

{ #category : #tests }
ViennaProductTypeTest >> testAmpersand [

	| nat real char unit |
	nat := ViennaType nat.
	real := ViennaType real.
	char := ViennaType char.
	unit := ViennaType unit.
	self assert: nat * nat & (nat * nat) equals: nat * nat.
	self assert: real * nat & (nat * real) equals: nat * nat.
	self
		assert: nat * (char | nat) & (nat | char * nat)
		equals: nat * nat
]

{ #category : #tests }
ViennaProductTypeTest >> testDo [
	self should: [ natBool do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | quoteBool do: [ :v | stream nextPut: v ] ]) asSet
		equals: #(#(#QUOTE true) #(#QUOTE false)) asSet
]

{ #category : #tests }
ViennaProductTypeTest >> testIncludes [
	self assert: (natBool includes: #(1 true)).
	self assert: (quoteBool includes: #(#QUOTE false))
]

{ #category : #tests }
ViennaProductTypeTest >> testIsCompatibleWith [

	self assert: (natBool isCompatibleWith: natBool).
	self deny: (natBool isCompatibleWith: quoteBool)
]

{ #category : #tests }
ViennaProductTypeTest >> testIsEnumerable [
	self deny: natBool isEnumerable.
	self assert: quoteBool isEnumerable
]

{ #category : #tests }
ViennaProductTypeTest >> testName [
	self assert: natBool name equals: 'nat*bool'.
	self assert: quoteBool name equals: '<QUOTE>*bool'
]

{ #category : #tests }
ViennaProductTypeTest >> testPlus [

	| nat nat1 char |
	nat := ViennaType nat.
	nat1 := ViennaType nat1.
	char := ViennaType char.
	self assert: nat * char + (nat * char) equals: nat * char.
	self assert: nat1 * char + (nat * char) equals: nat * char.
	self assert: nat * char + (nat1 * char) equals: nat * char.
	self
		assert: nat * char + (char * char)
		equals: nat | char * char
]

{ #category : #test }
ViennaProductTypeTest >> testPossibleTypesDo [

	self
		assert: (ViennaType union: (ViennaType nat | ViennaType char
				  * (ViennaType nat seq | ViennaType char seq)
				  * (ViennaType nat set | ViennaType char set)) possibleTypes)
		equals:
			'nat*seq of nat*set of nat|char*seq of nat*set of nat|nat*seq of char*set of nat|char*seq of char*set of nat|nat*seq of nat*set of char|char*seq of nat*set of char|nat*seq of char*set of char|char*seq of char*set of char'
				asViennaTypeAst asMaximalViennaType
]

{ #category : #tests }
ViennaProductTypeTest >> testRemoveTypeHolders [
	self
		assert: (ViennaType nat asTypeHolder * ViennaType int asTypeHolder) removeTypeHolders
		equals: ViennaType nat * ViennaType int
]

{ #category : #tests }
ViennaProductTypeTest >> testSubtype [
	self assert: natBool <= natBool.
	self deny: natBool <= quoteBool.
	self deny: ViennaType nat <= natBool
]
