Class {
	#name : #ViennaQuoteTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'quote'
	],
	#category : 'ViennaTalk-Type-Tests'
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
ViennaQuoteTypeTest >> testIsEnumerable [
	self assert: quote isEnumerable
]

{ #category : #tests }
ViennaQuoteTypeTest >> testName [
	self assert: quote name equals: '<QUOTE>'
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
