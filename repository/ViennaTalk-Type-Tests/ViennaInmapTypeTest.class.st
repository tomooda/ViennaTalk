Class {
	#name : #ViennaInmapTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'bool2optbool',
		'bool2nat'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaInmapTypeTest >> setUp [
	super setUp.
	bool2nat := ViennaInmapType with: ViennaType bool with: ViennaType nat.
	bool2optbool := ViennaInmapType with: ViennaType bool with: ViennaType bool optional
]

{ #category : #tests }
ViennaInmapTypeTest >> testDo [
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
			(Dictionary newFromPairs: #(true true false false)).
			(Dictionary newFromPairs: #(true true false nil)).
			(Dictionary newFromPairs: #(true false false true)).
			(Dictionary newFromPairs: #(true false false nil)).
			(Dictionary newFromPairs: #(true nil false true)).
			(Dictionary newFromPairs: #(true nil false false))} asSet
]

{ #category : #tests }
ViennaInmapTypeTest >> testIncludes [
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
		deny:
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
ViennaInmapTypeTest >> testIsCompatibleWith [

	self assert: (bool2nat isCompatibleWith: bool2nat).
	self deny: (bool2nat isCompatibleWith: bool2optbool)
]

{ #category : #tests }
ViennaInmapTypeTest >> testIsEnumerable [
	self deny: bool2nat isEnumerable.
	self assert: bool2optbool isEnumerable
]

{ #category : #tests }
ViennaInmapTypeTest >> testName [
	self assert: bool2nat name equals: 'inmap bool to nat'.
	self assert: bool2optbool name equals: 'inmap bool to [bool]'.
	self
		assert: (ViennaInmapType with: ViennaType bool with: ViennaType nat | ViennaType bool) name
		equals: 'inmap bool to (nat|bool)'
]

{ #category : #tests }
ViennaInmapTypeTest >> testRemoveTypeHolders [
	self
		assert: (ViennaType int asTypeHolder inmapTo: ViennaType nat asTypeHolder) removeTypeHolders
		equals: (ViennaType int inmapTo: ViennaType nat)
]

{ #category : #tests }
ViennaInmapTypeTest >> testSubtype [
	self assert: bool2optbool <= bool2optbool.
	self deny: bool2optbool <= bool2nat.
	self assert: (ViennaType inmap: ViennaType bool to: ViennaType bool) <= bool2optbool.
	self deny: bool2optbool <= (ViennaType inmap: ViennaType bool to: ViennaType bool).
	self assert: bool2optbool <= (ViennaType map: bool2optbool keytype to: bool2optbool valuetype).
	self deny: bool2optbool >= (ViennaType map: bool2optbool keytype to: bool2optbool valuetype)
]
