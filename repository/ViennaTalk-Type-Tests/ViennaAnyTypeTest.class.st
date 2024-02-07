Class {
	#name : #ViennaAnyTypeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #tests }
ViennaAnyTypeTest >> testIsCompatibleWith [

	self assert: (ViennaType any isCompatibleWith: ViennaType any).
	self assert: (ViennaType any isCompatibleWith: ViennaType char).
	self assert: (ViennaType any isCompatibleWith: ViennaType char set).
	self deny: (ViennaType any isCompatibleWith: ViennaType unit)
]

{ #category : #tests }
ViennaAnyTypeTest >> testPlus [

	self assert: ViennaType any + ViennaType any equals: ViennaType any.
	self assert: ViennaType any + ViennaType nat equals: ViennaType any.
	self assert: ViennaType nat + ViennaType any equals: ViennaType any
]
