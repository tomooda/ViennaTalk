"
A ViennaPatternIdentifierNodeTest is a test class for testing the behavior of ViennaPatternIdentifierNode
"
Class {
	#name : #ViennaPatternIdentifierNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaPatternIdentifierNodeTest >> testMaximalType [

	| p |
	p := ViennaPatternIdentifierNode identifier: 'p'.
	self assert: p maximalType equals: ViennaType unit.
	p maximalType: ViennaType char.
	self assert: p maximalType equals: ViennaType char
]
