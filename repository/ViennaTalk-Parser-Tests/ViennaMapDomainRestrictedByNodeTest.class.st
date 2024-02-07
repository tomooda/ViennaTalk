"
A ViennaMapDomainRestrictedByNodeTest is a test class for testing the behavior of ViennaMapDomainRestrictedByNode
"
Class {
	#name : #ViennaMapDomainRestrictedByNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaMapDomainRestrictedByNodeTest >> testMaximalType [

	| expr |
	expr := 's <-: m' asViennaExpressionAst.

	expr expression1 maximalType: ViennaType nat set.
	expr expression2 maximalType: (ViennaType nat mapTo: ViennaType char).
	self
		assert: expr maximalType
		equals: (ViennaType nat mapTo: ViennaType char).
	expr expression1 maximalType: ViennaType nat optional set.
	expr expression2 maximalType:
		(ViennaType real mapTo: ViennaType char).
	self
		assert: expr maximalType
		equals: (ViennaType real mapTo: ViennaType char).
	expr expression1 maximalType: ViennaType char set.
	expr expression2 maximalType: (ViennaType nat mapTo: ViennaType char).
	self should: [ expr maximalType ] raise: ViennaTypeError
]
