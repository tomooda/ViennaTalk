Class {
	#name : #ViennaOptionTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'optionNat',
		'optionQuote'
	],
	#category : 'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaOptionTypeTest >> setUp [
	super setUp.
	optionNat := ViennaOptionType with: ViennaType nat.
	optionQuote := ViennaOptionType with: (ViennaType quote: #'<QUOTE>')
]

{ #category : #tests }
ViennaOptionTypeTest >> testDo [
	self should: [ optionNat do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | optionQuote do: [ :v | stream nextPut: v ] ]) asSet
		equals: #(#'<QUOTE>' nil) asSet
]

{ #category : #tests }
ViennaOptionTypeTest >> testIncludes [
	self assert: (optionNat includes: 1).
	self assert: (optionNat includes: nil)
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
ViennaOptionTypeTest >> testSubtype [
	self assert: optionNat <= optionNat.
	self deny: optionNat <= optionQuote.
	self assert: ViennaType nat <= optionNat.
	self deny: optionNat <= ViennaType nat
]
