Class {
	#name : #ViennaSet1TypeTest,
	#superclass : #TestCase,
	#instVars : [
		'set1ofnat',
		'set1ofbool'
	],
	#category : 'ViennaTalk-Type-Tests'
}

{ #category : #'as yet unclassified' }
ViennaSet1TypeTest >> setUp [
	super setUp.
	set1ofnat := ViennaSet1Type with: ViennaType nat.
	set1ofbool := ViennaSet1Type with: ViennaType bool
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
ViennaSet1TypeTest >> testIncludes [
	self deny: (set1ofnat includes: {} asSet).
	self assert: (set1ofnat includes: {1} asSet).
	self deny: (set1ofnat includes: {1 . -1} asSet)
]

{ #category : #'as yet unclassified' }
ViennaSet1TypeTest >> testIsEnumerable [
	self deny: set1ofnat isEnumerable.
	self assert: set1ofbool isEnumerable
]

{ #category : #'as yet unclassified' }
ViennaSet1TypeTest >> testName [
	self assert: set1ofnat name equals: 'set1 of nat'.
	self assert: set1ofbool name equals: 'set1 of bool'
]

{ #category : #'as yet unclassified' }
ViennaSet1TypeTest >> testSubtype [
	self assert: set1ofbool <= set1ofbool.
	self deny: set1ofbool <= set1ofnat.
	self assert: set1ofbool <= (ViennaType setOf: ViennaType bool | ViennaType nat).
	self deny: (ViennaType setOf: ViennaType bool | ViennaType nat) <= set1ofbool.
	self assert: set1ofbool <= (ViennaType setOf: ViennaType bool).
	self deny: (ViennaType setOf: ViennaType bool) <= set1ofbool
]
