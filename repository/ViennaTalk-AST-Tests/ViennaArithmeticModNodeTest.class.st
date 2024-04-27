Class {
	#name : #ViennaArithmeticModNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaArithmeticModNodeTest >> testMaximalType [

	self
		assert: '3 mod 2' asViennaExpressionAst maximalType
		equals: ViennaType nat.
	self
		assert: '-3 mod 2' asViennaExpressionAst maximalType
		equals: ViennaType nat.
	self
		assert: '3 mod -2' asViennaExpressionAst maximalType
		equals: ViennaType int.
	self
		should: [ 'nil mod 2' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [ '2 mod nil' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
