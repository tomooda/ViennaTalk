Class {
	#name : #ViennaArithmaticModNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaArithmaticModNodeTest >> testMaximalType [

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
