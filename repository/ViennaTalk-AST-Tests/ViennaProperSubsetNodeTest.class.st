"
A ViennaProperSubsetNodeTest is a test class for testing the behavior of ViennaProperSubsetNode
"
Class {
	#name : 'ViennaProperSubsetNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaProperSubsetNodeTest >> testMaximalType [

	| expr |
	expr := 's1 psubset s2' asViennaExpressionAst.
	expr expression1 setMaximalType: ViennaType nat set.
	expr expression2 setMaximalType: ViennaType nat set.
	self assert: expr maximalType equals: ViennaType bool.

	expr expression1 setMaximalType: ViennaType nat optional set.
	expr expression2 setMaximalType: ViennaType char optional set.
	self assert: expr maximalType equals: ViennaType bool.

	expr expression1 setMaximalType: ViennaType nat set.
	expr expression2 setMaximalType: ViennaType char set.
	self should: [ expr maximalType ] raise: ViennaTypeError
]
