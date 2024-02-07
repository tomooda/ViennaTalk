"
A ViennaProperSubsetNodeTest is a test class for testing the behavior of ViennaProperSubsetNode
"
Class {
	#name : #ViennaProperSubsetNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaProperSubsetNodeTest >> testTypecheck [

	| expr |
	expr := 's1 psubset s2' asViennaExpressionAst.
	expr expression1 maximalType: ViennaType nat set.
	expr expression2 maximalType: ViennaType nat set.
	self
		assert: (expr typecheck: ViennaType bool)
		equals: ViennaType bool.

	expr expression1 maximalType: ViennaType nat optional set.
	expr expression2 maximalType: ViennaType char optional set.
	self
		assert: (expr typecheck: ViennaType bool)
		equals: ViennaType bool.

	expr expression1 maximalType: ViennaType nat set.
	expr expression2 maximalType: ViennaType char set.
	self
		should: [ expr typecheck: ViennaType bool ]
		raise: ViennaTypeError
]