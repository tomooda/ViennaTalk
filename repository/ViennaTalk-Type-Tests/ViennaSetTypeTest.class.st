Class {
	#name : #ViennaSetTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'setofnat',
		'setofbool'
	],
	#category : 'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaSetTypeTest >> setUp [
	super setUp.
	setofnat := ViennaSetType with: ViennaType nat.
	setofbool := ViennaSetType with: ViennaType bool
]

{ #category : #tests }
ViennaSetTypeTest >> testDo [
	self should: [ setofnat do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | setofbool do: [ :v | stream nextPut: v ] ]) asSet
		equals:
			{({} asSet).
			({true} asSet).
			({false} asSet).
			({true.
			false} asSet)} asSet
]

{ #category : #tests }
ViennaSetTypeTest >> testIncludes [
	self assert: (setofnat includes: {} asSet).
	self assert: (setofnat includes: {1} asSet).
	self deny: (setofnat includes: {1 . -1} asSet)
]

{ #category : #tests }
ViennaSetTypeTest >> testIsEnumerable [
	self deny: setofnat isEnumerable.
	self assert: setofbool isEnumerable
]

{ #category : #tests }
ViennaSetTypeTest >> testName [
	self assert: setofnat name equals: 'set of nat'.
	self assert: setofbool name equals: 'set of bool'
]

{ #category : #tests }
ViennaSetTypeTest >> testSubset [
	self assert: setofbool <= setofbool.
	self deny: setofbool <= setofnat.
	self assert: setofbool <= (ViennaType setOf: ViennaType bool | ViennaType nat).
	self deny: (ViennaType setOf: ViennaType bool | ViennaType nat) <= setofbool
]