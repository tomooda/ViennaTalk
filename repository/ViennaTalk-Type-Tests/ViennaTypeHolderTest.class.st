Class {
	#name : #ViennaTypeHolderTest,
	#superclass : #TestCase,
	#instVars : [
		'char'
	],
	#category : 'ViennaTalk-Type-Tests'
}

{ #category : #tests }
ViennaTypeHolderTest >> testRemoveTypeHolders [
	self
		assert: (ViennaType nat asTypeHolder mapTo: ViennaType int) asTypeHolder removeTypeHolders
		equals: (ViennaType nat mapTo: ViennaType int)
]
