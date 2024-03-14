"
A ViennaMapMergeNodeTest is a test class for testing the behavior of ViennaMapMergeNode
"
Class {
	#name : #ViennaMapMergeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaMapMergeNodeTest >> testMaximalType [

	| expr |
	expr := 'm1 munion m2' asViennaExpressionAst.

	expr expression1 setMaximalType:
		(ViennaType nat mapTo: ViennaType char).
	expr expression2 setMaximalType:
		(ViennaType nat mapTo: ViennaType char).
	self
		assert: expr maximalType
		equals: (ViennaType nat mapTo: ViennaType char).

	expr expression1 setMaximalType:
		(ViennaType nat optional mapTo: ViennaType char).
	expr expression2 setMaximalType:
		(ViennaType nat mapTo: ViennaType char optional).
	self
		assert: expr maximalType
		equals: (ViennaType nat optional mapTo: ViennaType char optional).

	expr expression1 setMaximalType:
		(ViennaType nat mapTo: ViennaType char).
	expr expression2 setMaximalType:
		(ViennaType char mapTo: ViennaType nat).
	self
		assert: expr maximalType
		equals: (ViennaType nat | ViennaType char mapTo:
				 ViennaType char | ViennaType nat)
]
