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
