"
A ViennaMapRangeRestrictedByNodeTest is a test class for testing the behavior of ViennaMapRangeRestrictedByNode
"
Class {
	#name : #ViennaMapRangeRestrictedByNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaMapRangeRestrictedByNodeTest >> testMaximalType [

	| expr |
	expr := 'm :-> s' asViennaExpressionAst.

	expr expression1 setMaximalType:
		(ViennaType nat mapTo: ViennaType char).
	expr expression2 setMaximalType: ViennaType char set.
	self
		assert: expr maximalType
		equals: (ViennaType nat mapTo: ViennaType char).
	expr expression1 setMaximalType:
		(ViennaType real mapTo: ViennaType char).
	self
		assert: expr maximalType
		equals: (ViennaType real mapTo: ViennaType char).
	expr expression1 setMaximalType:
		(ViennaType nat mapTo: ViennaType char).
	expr expression2 setMaximalType: ViennaType nat set.
	self should: [ expr maximalType ] raise: ViennaTypeError
]
