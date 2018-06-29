Class {
	#name : #ViennaUnionTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'natBool',
		'quoteBool'
	],
	#category : 'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaUnionTypeTest >> setUp [
	super setUp.
	natBool := ViennaUnionType with: ViennaType nat with: ViennaType bool.
	quoteBool := ViennaUnionType with: (ViennaType quote: #'QUOTE') with: ViennaType bool
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
