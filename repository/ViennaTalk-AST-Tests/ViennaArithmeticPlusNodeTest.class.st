Class {
	#name : 'ViennaArithmeticPlusNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaArithmeticPlusNodeTest >> testMaximalType [

	self
		assert: '3 + 2' asViennaExpressionAst maximalType
		equals: ViennaType nat1.
	self
		assert: '3 + 0' asViennaExpressionAst maximalType
		equals: ViennaType nat1.
	self
		assert: '0 + 0' asViennaExpressionAst maximalType
		equals: ViennaType nat.
	self
		assert: '3 + -2' asViennaExpressionAst maximalType
		equals: ViennaType int.
	self
		assert: '3.14 + 2' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		should: [ '3.14 + true' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [ 'true + 2' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
