Class {
	#name : #ViennaArithmeticRemNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaArithmeticRemNodeTest >> testMaximalType [

	self
		assert: '3 rem 2' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		assert: '-3 rem 2' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		assert: '3 rem -2' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		assert: '3.14 rem 2' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		should: [ '3.14 rem true' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [ 'true rem 2' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
