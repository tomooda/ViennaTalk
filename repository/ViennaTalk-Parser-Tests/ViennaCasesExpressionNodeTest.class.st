Class {
	#name : #ViennaCasesExpressionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaCasesExpressionNodeTest >> testMaximalType [

	self
		assert: 'cases 1: x -> x end' asViennaExpressionAst maximalType
		equals: ViennaType nat1.
	self
		assert:
		'cases 1: x -> x + 3.14 end' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		should: [
		'cases 1: x -> x and false end' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
