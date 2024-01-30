Class {
	#name : #ViennaSet1TypeTest,
	#superclass : #TestCase,
	#instVars : [
		'set1ofnat',
		'set1ofbool'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaSet1TypeTest >> setUp [
	super setUp.
	set1ofnat := ViennaSet1Type with: ViennaType nat.
	set1ofbool := ViennaSet1Type with: ViennaType bool
]

{ #category : #tests }
ViennaSet1TypeTest >> testDo [
	self should: [ set1ofnat do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | set1ofbool do: [ :v | stream nextPut: v ] ]) asSet
		equals:
			{({} asSet).
			({true} asSet).
			({false} asSet).
			({true.
			false} asSet)} asSet
]

{ #category : #tests }
ViennaSet1TypeTest >> testIncludes [
	self deny: (set1ofnat includes: {} asSet).
	self assert: (set1ofnat includes: {1} asSet).
	self deny: (set1ofnat includes: {1 . -1} asSet)
]

{ #category : #tests }
ViennaSet1TypeTest >> testIsCompatibleWith [

	self assert:
		(ViennaType char set1 isCompatibleWith: ViennaType char set1).
	self assert:
		(ViennaType char set1 isCompatibleWith: ViennaType char set).
	self deny: (ViennaType char set1 isCompatibleWith: ViennaType char).
	self deny:
		(ViennaType char set1 isCompatibleWith: ViennaType nat set1).
	self deny:
		(ViennaType char set1 isCompatibleWith: ViennaType char seq1)
]

{ #category : #tests }
ViennaSet1TypeTest >> testIsEnumerable [
	self deny: set1ofnat isEnumerable.
	self assert: set1ofbool isEnumerable
]

{ #category : #tests }
ViennaSet1TypeTest >> testName [
	self assert: set1ofnat name equals: 'set1 of nat'.
	self assert: set1ofbool name equals: 'set1 of bool'
]

{ #category : #tests }
ViennaSet1TypeTest >> testRemoveTypeHolders [
	self
		assert: ViennaType nat asTypeHolder set1 removeTypeHolders
		equals: ViennaType nat set1
]

{ #category : #tests }
ViennaSet1TypeTest >> testSubtype [
	self assert: set1ofbool <= set1ofbool.
	self deny: set1ofbool <= set1ofnat.
	self assert: set1ofbool <= (ViennaType setOf: ViennaType bool | ViennaType nat).
	self deny: (ViennaType setOf: ViennaType bool | ViennaType nat) <= set1ofbool.
	self assert: set1ofbool <= (ViennaType setOf: ViennaType bool).
	self deny: (ViennaType setOf: ViennaType bool) <= set1ofbool
]
