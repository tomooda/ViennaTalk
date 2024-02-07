Class {
	#name : #ViennaOptionTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'optionNat',
		'optionQuote'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaOptionTypeTest >> setUp [
	super setUp.
	optionNat := ViennaOptionType with: ViennaType nat.
	optionQuote := ViennaOptionType with: (ViennaType quote: #QUOTE)
]

{ #category : #tests }
ViennaOptionTypeTest >> testDo [
	self should: [ optionNat do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert:
			(Array new: 1 streamContents: [ :stream | optionQuote do: [ :v | stream nextPut: v ] ])
				asSet
		equals: #(#QUOTE nil) asSet
]

{ #category : #tests }
ViennaOptionTypeTest >> testIncludes [
	self assert: (optionNat includes: 1).
	self assert: (optionNat includes: nil)
]

{ #category : #tests }
ViennaOptionTypeTest >> testIsCompatibleWith [

	self assert: (optionNat isCompatibleWith: optionNat).
	self assert: (optionNat isCompatibleWith: optionQuote).
	self deny: (optionNat isCompatibleWith: ViennaType char)
]

{ #category : #tests }
ViennaOptionTypeTest >> testIsEnumerable [
	self deny: optionNat isEnumerable.
	self assert: optionQuote isEnumerable
]

{ #category : #tests }
ViennaOptionTypeTest >> testName [
	self assert: optionNat name equals: '[nat]'.
	self assert: optionQuote name equals: '[<QUOTE>]'
]

{ #category : #tests }
ViennaOptionTypeTest >> testPlus [

	| nat char unit |
	nat := ViennaType nat.
	char := ViennaType char.
	unit := ViennaType unit.
	self assert: nat optional + nat optional equals: nat optional.
	self assert: nat optional + nat equals: nat optional.
	self assert: nat + nat optional equals: nat optional.
	self
		assert: nat optional + char optional
		equals: (nat | char) optional.
	self assert: nat optional + char equals: (nat | char) optional.
	self assert: nat + char optional equals: (nat | char) optional.
	self assert: unit optional + char equals: char optional.
	self assert: char + unit optional equals: char optional
]

{ #category : #tests }
ViennaOptionTypeTest >> testRemoveTypeHolders [
	self
		assert: ViennaType nat asTypeHolder optional removeTypeHolders
		equals: ViennaType nat optional
]

{ #category : #tests }
ViennaOptionTypeTest >> testSubtype [
	self assert: optionNat <= optionNat.
	self deny: optionNat <= optionQuote.
	self assert: ViennaType nat <= optionNat.
	self deny: optionNat <= ViennaType nat
]
