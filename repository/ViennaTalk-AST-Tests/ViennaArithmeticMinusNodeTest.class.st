Class {
	#name : #ViennaArithmeticMinusNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaArithmeticMinusNodeTest >> testMaximalType [

	self
		assert: '3 - 2' asViennaExpressionAst maximalType
		equals: ViennaType int.
	self
		assert: '3.14 - 2' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		should: [ '3.14 - true' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [ 'true - 2' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
