"
A ViennaArithmeticAbsNodeTest is a test class for testing the behavior of ViennaArithmeticAbsNode
"
Class {
	#name : #ViennaArithmeticAbsNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaArithmeticAbsNodeTest >> testMaximalType [

	self
		assert: 'abs 2' asViennaExpressionAst maximalType
		equals: ViennaType nat1.
	self
		assert: 'abs -2' asViennaExpressionAst maximalType
		equals: ViennaType nat.
	self
		assert: 'abs -1.41421356' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		should: [ 'abs nil' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
