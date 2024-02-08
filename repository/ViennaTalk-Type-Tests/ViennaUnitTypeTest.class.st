Class {
	#name : #ViennaUnitTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'unit'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaUnitTypeTest >> setUp [

	super setUp.
	unit := ViennaUnitType current
]

{ #category : #tests }
ViennaUnitTypeTest >> testAmpersand [

	| any |
	any := ViennaType any.
	self assert: unit & unit equals: unit.
	self assert: unit & any equals: unit.
	self assert: any & unit equals: unit
]

{ #category : #tests }
ViennaUnitTypeTest >> testDo [

	unit do: [ :x | self fail ]
]

{ #category : #tests }
ViennaUnitTypeTest >> testIncludes [

	self deny: (unit includes: 0).
	self deny: (unit includes: nil)
]

{ #category : #tests }
ViennaUnitTypeTest >> testIsCompatibleWith [

	self assert: (ViennaType unit isCompatibleWith: ViennaType unit).
	self deny: (ViennaType unit isCompatibleWith: ViennaType char).
	self deny: (ViennaType unit isCompatibleWith: ViennaType any).
	self deny: (ViennaType any isCompatibleWith: ViennaType unit)
]

{ #category : #tests }
ViennaUnitTypeTest >> testIsEnumerable [
	self assert: unit isEnumerable
]

{ #category : #tests }
ViennaUnitTypeTest >> testName [
	self assert: unit name equals: '()'
]

{ #category : #tests }
ViennaUnitTypeTest >> testPlus [

	| nat char token |
	nat := ViennaType nat.
	char := ViennaType char.
	token := ViennaType token.
	self assert: unit + nat equals: nat.
	self assert: nat + unit equals: nat.
	self assert: unit optional + nat equals: nat optional.
	self assert: nat + unit optional equals: nat optional
]

{ #category : #tests }
ViennaUnitTypeTest >> testRemoveTypeHolders [
	self assert: unit asTypeHolder removeTypeHolders equals: unit
]

{ #category : #tests }
ViennaUnitTypeTest >> testSubtype [

	self assert: unit <= unit.
	self assert: unit <= ViennaType int.
	self deny: unit >= ViennaType int.
	self deny: ViennaType int <= unit
]
