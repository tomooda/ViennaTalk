Class {
	#name : #ViennaArithmeticDivideNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaArithmeticDivideNodeTest >> testMaximalType [

	self
		assert: '4 / 2' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		assert: '3.14 / 2' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		should: [ '3.14 / true' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [ 'true / 2' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
