"
A ViennaMapMergeNodeTest is a test class for testing the behavior of ViennaMapMergeNode
"
Class {
	#name : #ViennaMapMergeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaMapMergeNodeTest >> testTypecheck [

	| expr |
	expr := 'm1 munion m2' asViennaExpressionAst.

	expr expression1 maximalType: (ViennaType nat mapTo: ViennaType char).
	expr expression2 maximalType: (ViennaType nat mapTo: ViennaType char).
	self
		assert: (expr typecheck: (ViennaType nat mapTo: ViennaType char))
		equals: (ViennaType nat mapTo: ViennaType char).

	expr expression1 maximalType:
		(ViennaType nat optional mapTo: ViennaType char).
	expr expression2 maximalType:
		(ViennaType nat mapTo: ViennaType char optional).
	self
		assert: (expr typecheck:
				 (ViennaType nat optional mapTo: ViennaType char optional))
		equals: (ViennaType nat optional mapTo: ViennaType char optional).

	expr expression1 maximalType: (ViennaType nat mapTo: ViennaType char).
	expr expression2 maximalType: (ViennaType char mapTo: ViennaType nat).
	self
		assert: (expr typecheck: (ViennaType nat | ViennaType char mapTo:
					  ViennaType nat | ViennaType char))
		equals: (ViennaType nat | ViennaType char mapTo:
				 ViennaType char | ViennaType nat)
]
