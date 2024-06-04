"
A ViennaMapDomainRestrictedByNodeTest is a test class for testing the behavior of ViennaMapDomainRestrictedByNode
"
Class {
	#name : 'ViennaMapDomainRestrictedByNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaMapDomainRestrictedByNodeTest >> testMaximalType [

	| expr |
	expr := 's <-: m' asViennaExpressionAst.

	expr expression1 setMaximalType: ViennaType nat set.
	expr expression2 setMaximalType:
		(ViennaType nat mapTo: ViennaType char).
	self
		assert: expr maximalType
		equals: (ViennaType nat mapTo: ViennaType char).
	expr expression1 setMaximalType: ViennaType nat optional set.
	expr expression2 setMaximalType:
		(ViennaType real mapTo: ViennaType char).
	self
		assert: expr maximalType
		equals: (ViennaType real mapTo: ViennaType char).
	expr expression1 setMaximalType: ViennaType char set.
	expr expression2 setMaximalType:
		(ViennaType nat mapTo: ViennaType char).
	self should: [ expr maximalType ] raise: ViennaTypeError
]
