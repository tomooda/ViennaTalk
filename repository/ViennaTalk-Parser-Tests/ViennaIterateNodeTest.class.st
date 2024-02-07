Class {
	#name : #ViennaIterateNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaIterateNodeTest >> testMaximalType [

	| x_iterate_2 |
	x_iterate_2 := 'x ** 2' asViennaExpressionAst.

	x_iterate_2 expression1 maximalType:
		ViennaType char -> ViennaType char.
	self
		assert: x_iterate_2 maximalType
		equals: ViennaType char -> ViennaType char.

	x_iterate_2 expression1 maximalType:
		(ViennaType char mapTo: ViennaType char).
	self
		assert: x_iterate_2 maximalType
		equals: (ViennaType char mapTo: ViennaType char).

	x_iterate_2 expression1 maximalType: ViennaType real.
	self assert: x_iterate_2 maximalType equals: ViennaType real.

	self
		assert: '3.14 ** 2.1828' asViennaExpressionAst maximalType
		equals: ViennaType real.

	x_iterate_2 expression1 maximalType:
		ViennaType char -> ViennaType nat.
	self should: [ x_iterate_2 maximalType ] raise: ViennaTypeError.
	x_iterate_2 expression1 maximalType:
		(ViennaType char mapTo: ViennaType nat).
	self should: [ x_iterate_2 maximalType ] raise: ViennaTypeError
]
