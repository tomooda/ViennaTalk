"
A ViennaPatternIdentifierNodeTest is a test class for testing the behavior of ViennaPatternIdentifierNode
"
Class {
	#name : #ViennaPatternIdentifierNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaPatternIdentifierNodeTest >> testMaximalType [

	| p |
	p := ViennaPatternIdentifierNode identifier: 'p'.
	self assert: p maximalType equals: ViennaType any.
	p maximalType: ViennaType char.
	self assert: p typecheck equals: ViennaType char
]
