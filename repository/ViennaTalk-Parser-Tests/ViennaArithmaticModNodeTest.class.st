Class {
	#name : #ViennaArithmaticModNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaArithmaticModNodeTest >> testMaximalType [

	self
		assert: '3 mod 2' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		assert: '-3 mod 2' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		assert: '3 mod -2' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		assert: '3.14 mod 2' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		should: [ '3.14 mod true' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [ 'true mod 2' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
