Class {
	#name : #ViennaMapDomainRestrictedToNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaMapDomainRestrictedToNodeTest >> testTypecheck [

	| expr |
	expr := 's <: m' asViennaExpressionAst.

	expr expression1 maximalType: ViennaType nat set.
	expr expression2 maximalType: (ViennaType nat mapTo: ViennaType char).
	self
		assert: (expr typecheck: (ViennaType nat mapTo: ViennaType char))
		equals: (ViennaType nat mapTo: ViennaType char).
	expr expression1 maximalType: ViennaType nat optional set.
	expr expression2 maximalType:
		(ViennaType real mapTo: ViennaType char).
	self
		assert: (expr typecheck: (ViennaType real mapTo: ViennaType char))
		equals: (ViennaType real mapTo: ViennaType char).
	expr expression1 maximalType: ViennaType char set.
	expr expression2 maximalType: (ViennaType nat mapTo: ViennaType char).
	self
		should: [ expr typecheck: (ViennaType real mapTo: ViennaType char) ]
		raise: ViennaTypeError
]
