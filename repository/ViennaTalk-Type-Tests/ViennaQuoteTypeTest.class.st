Class {
	#name : #ViennaQuoteTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'quote'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaQuoteTypeTest >> setUp [

	super setUp.
	quote := ViennaQuoteType with: #QUOTE
]

{ #category : #tests }
ViennaQuoteTypeTest >> testDo [
	self assert: (Array new: 1 streamContents: [ :stream | quote do: [ :v | stream nextPut: v ] ]) equals: #(#QUOTE)
]

{ #category : #tests }
ViennaQuoteTypeTest >> testIncludes [
	self assert: (quote includes: #QUOTE).
	self deny: (quote includes: 'QUOTE').
	self deny: (quote includes: $a)
]

{ #category : #tests }
ViennaQuoteTypeTest >> testIsCompatibleWith [

	self assert: ((ViennaType quote: 'QUOTE') isCompatibleWith:
			 (ViennaType quote: 'QUOTE')).
	self deny: ((ViennaType quote: 'QUOTE') isCompatibleWith:
			 (ViennaType quote: 'QUOTE1')).
	self deny:
		((ViennaType quote: 'QUOTE') isCompatibleWith: ViennaType char)
]

{ #category : #tests }
ViennaQuoteTypeTest >> testIsEnumerable [
	self assert: quote isEnumerable
]

{ #category : #tests }
ViennaQuoteTypeTest >> testName [
	self assert: quote name equals: '<QUOTE>'
]

{ #category : #tests }
ViennaQuoteTypeTest >> testPlus [

	| quote1 quote2 |
	quote1 := ViennaType quote: 'quote1'.
	quote2 := ViennaType quote: 'quote2'.
	self assert: quote1 + quote1 equals: quote1.
	self assert: quote1 + quote2 equals: quote1 | quote2
]

{ #category : #tests }
ViennaQuoteTypeTest >> testRemoveTypeHolders [
	self
		assert: (ViennaType quote: #Q) asTypeHolder removeTypeHolders
		equals: (ViennaType quote: #Q)
]

{ #category : #tests }
ViennaQuoteTypeTest >> testSubtype [
	self assert: quote <= quote.
	self deny: quote <= (ViennaType quote: 'ANOTHER')
]
