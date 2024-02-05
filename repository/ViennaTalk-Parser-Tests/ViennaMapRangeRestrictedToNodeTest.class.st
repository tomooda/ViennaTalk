Class {
	#name : #ViennaMapRangeRestrictedToNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaMapRangeRestrictedToNodeTest >> testTypecheck [

	| expr |
	expr := 'm :> s' asViennaExpressionAst.

	expr expression1 maximalType: (ViennaType nat mapTo: ViennaType char).
	expr expression2 maximalType: ViennaType char set.
	self
		assert: (expr typecheck: (ViennaType nat mapTo: ViennaType char))
		equals: (ViennaType nat mapTo: ViennaType char).
	expr expression1 maximalType:
		(ViennaType real mapTo: ViennaType char).
	self
		assert: (expr typecheck: (ViennaType real mapTo: ViennaType char))
		equals: (ViennaType real mapTo: ViennaType char).
	expr expression1 maximalType: (ViennaType nat mapTo: ViennaType char).
	expr expression2 maximalType: ViennaType nat set.
	self
		should: [ expr typecheck: (ViennaType real mapTo: ViennaType char) ]
		raise: ViennaTypeError
]
