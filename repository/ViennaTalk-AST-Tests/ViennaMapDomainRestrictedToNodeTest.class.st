Class {
	#name : #ViennaMapDomainRestrictedToNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaMapDomainRestrictedToNodeTest >> testMaximalType [

	| expr |
	expr := 's <: m' asViennaExpressionAst.

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
