Class {
	#name : #ViennaUnionTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'natBool',
		'quoteBool'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaUnionTypeTest >> setUp [
	super setUp.
	natBool := ViennaUnionType with: ViennaType nat with: ViennaType bool.
	quoteBool := ViennaUnionType with: (ViennaType quote: #'QUOTE') with: ViennaType bool
]

{ #category : #tests }
ViennaUnionTypeTest >> testAmpersand [

	| nat real char unit |
	nat := ViennaType nat.
	real := ViennaType real.
	char := ViennaType char.
	unit := ViennaType unit.
	self assert: nat | char & (nat | char) equals: nat | char.
	self
		assert: char | unit | nat & (real | (real | char optional))
		equals: char | nat
]

{ #category : #tests }
ViennaUnionTypeTest >> testDo [
	self should: [ natBool do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | quoteBool do: [ :v | stream nextPut: v ] ]) asSet
		equals: #(#QUOTE true false) asSet
]

{ #category : #tests }
ViennaUnionTypeTest >> testIncludes [
	self assert: (natBool includes: 1).
	self assert: (natBool includes: true).
	self assert: (quoteBool includes: #QUOTE).
	self assert: (quoteBool includes: false).
	self deny: (quoteBool includes: #NOQUOTE)
]

{ #category : #tests }
ViennaUnionTypeTest >> testIsCompatibleWith [

	self assert: (ViennaType nat | ViennaType char isCompatibleWith:
			 ViennaType nat | ViennaType char).
	self assert:
		(ViennaType nat | ViennaType char isCompatibleWith: ViennaType nat).
	self assert:
		(ViennaType nat isCompatibleWith: ViennaType nat | ViennaType char).
	self deny: (ViennaType nat | ViennaType char isCompatibleWith:
			 (ViennaType quote: 'QUOTE') | ViennaType token).
	self assert: (ViennaType nat optional isCompatibleWith:
			 ViennaType nat | ViennaType char optional).
	self assert: (ViennaType nat optional isCompatibleWith:
			 (ViennaType quote: 'QUOTE') | ViennaType char optional)
]

{ #category : #tests }
ViennaUnionTypeTest >> testIsEnumerable [
	self deny: natBool isEnumerable.
	self assert: quoteBool isEnumerable
]

{ #category : #tests }
ViennaUnionTypeTest >> testName [
	self assert: natBool name equals: 'nat|bool'.
	self assert: quoteBool name equals: '<QUOTE>|bool'
]

{ #category : #tests }
ViennaUnionTypeTest >> testPlus [

	| nat char token unit |
	nat := ViennaType nat.
	char := ViennaType char.
	token := ViennaType token.
	unit := ViennaType unit.
	self assert: nat | char + (nat | char) equals: nat | char.
	self assert: nat | char + nat equals: nat | char.
	self assert: nat | char + (char | nat) equals: nat | char.
	self assert: nat | char + (nat | token) equals: nat | char | token
]

{ #category : #tests }
ViennaUnionTypeTest >> testRemoveTypeHolders [
	self
		assert: (ViennaType nat asTypeHolder | ViennaType int asTypeHolder) removeTypeHolders
		equals: ViennaType nat | ViennaType int
]

{ #category : #tests }
ViennaUnionTypeTest >> testSubtype [
	self assert: natBool <= natBool.
	self assert: ViennaType nat <= natBool.
	self assert: ViennaType bool <= natBool.
	self deny: natBool <= ViennaType nat.
	self deny: natBool <= ViennaType bool
]
