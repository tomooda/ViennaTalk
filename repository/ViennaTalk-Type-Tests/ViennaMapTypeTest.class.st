Class {
	#name : #ViennaMapTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'bool2optbool',
		'bool2nat'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaMapTypeTest >> setUp [
	super setUp.
	bool2nat := ViennaMapType with: ViennaType bool with: ViennaType nat.
	bool2optbool := ViennaMapType with: ViennaType bool with: ViennaType bool optional
]

{ #category : #tests }
ViennaMapTypeTest >> testAmpersand [

	| nat real char unit |
	nat := ViennaType nat.
	real := ViennaType real.
	char := ViennaType char.
	unit := ViennaType unit.
	self
		assert: (nat mapTo: char) & (nat mapTo: char)
		equals: (nat mapTo: char).
	self
		assert: (real mapTo: char) & (nat inmapTo: char optional)
		equals: (nat inmapTo: char).
	self assert: (nat mapTo: char) & (char mapTo: char) equals: unit
]

{ #category : #tests }
ViennaMapTypeTest >> testDo [
	self should: [ bool2nat do: [ :i |  ] ] raise: ShouldNotImplement.
	self
		assert: (Array new: 1 streamContents: [ :stream | bool2optbool do: [ :v | stream nextPut: v ] ]) asSet
		equals:
			{(Dictionary newFromPairs: #()).
			(Dictionary newFromPairs: #(true true)).
			(Dictionary newFromPairs: #(true false)).
			(Dictionary newFromPairs: #(true nil)).
			(Dictionary newFromPairs: #(false true)).
			(Dictionary newFromPairs: #(false false)).
			(Dictionary newFromPairs: #(false nil)).
			(Dictionary newFromPairs: #(true true false true)).
			(Dictionary newFromPairs: #(true true false false)).
			(Dictionary newFromPairs: #(true true false nil)).
			(Dictionary newFromPairs: #(true false false true)).
			(Dictionary newFromPairs: #(true false false false)).
			(Dictionary newFromPairs: #(true false false nil)).
			(Dictionary newFromPairs: #(true nil false true)).
			(Dictionary newFromPairs: #(true nil false false)).
			(Dictionary newFromPairs: #(true nil false nil))} asSet
]

{ #category : #tests }
ViennaMapTypeTest >> testIncludes [
	self assert: (bool2nat includes: Dictionary new).
	self
		assert:
			(bool2nat
				includes:
					(Dictionary new
						at: true put: 1;
						at: false put: 0;
						yourself)).
	self
		assert:
			(bool2nat
				includes:
					(Dictionary new
						at: true put: 0;
						at: false put: 0;
						yourself)).
	self
		deny:
			(bool2nat
				includes:
					(Dictionary new
						at: true put: 1;
						at: false put: 0.2;
						yourself))
]

{ #category : #tests }
ViennaMapTypeTest >> testIsCompatibleWith [

	self assert: (bool2nat isCompatibleWith: bool2nat).
	self deny: (bool2nat isCompatibleWith: bool2optbool)
]

{ #category : #tests }
ViennaMapTypeTest >> testIsEnumerable [
	self deny: bool2nat isEnumerable.
	self assert: bool2optbool isEnumerable
]

{ #category : #tests }
ViennaMapTypeTest >> testName [
	self assert: bool2nat name equals: 'map bool to nat'.
	self assert: bool2optbool name equals: 'map bool to [bool]'.
	self
		assert: (ViennaMapType with: ViennaType bool with: ViennaType nat | ViennaType bool) name
		equals: 'map bool to (nat|bool)'
]

{ #category : #tests }
ViennaMapTypeTest >> testPlus [

	self assert: bool2nat + bool2nat equals: bool2nat.
	self assert: bool2nat + bool2optbool equals: bool2nat | bool2optbool
]

{ #category : #tests }
ViennaMapTypeTest >> testRemoveTypeHolders [
	self
		assert: (ViennaType nat asTypeHolder mapTo: ViennaType int asTypeHolder) removeTypeHolders
		equals: (ViennaType nat mapTo: ViennaType int)
]

{ #category : #tests }
ViennaMapTypeTest >> testSubtype [
	self assert: bool2optbool <= bool2optbool.
	self deny: bool2optbool <= bool2nat.
	self assert: (ViennaType map: ViennaType bool to: ViennaType bool) <= bool2optbool.
	self deny: bool2optbool <= (ViennaType map: ViennaType bool to: ViennaType bool)
]
