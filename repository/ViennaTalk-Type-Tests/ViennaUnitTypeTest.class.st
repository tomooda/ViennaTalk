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
