Class {
	#name : 'ViennaCasesExpressionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaCasesExpressionNodeTest >> testMaximalType [

	self
		assert: 'cases 1: x -> x end' asViennaExpressionAst maximalType
		equals: ViennaType nat1.
	self
		assert:
		'cases 1: x -> x + 3.14 end' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		assert:
		'cases [1,2,3]: [x]^- -> x end' asViennaExpressionAst maximalType
		equals: ViennaType nat1.
	self
		assert:
			'cases [1,2,3]: [x]^- -> x, others -> nil end'
				asViennaExpressionAst maximalType
		equals: ViennaType nat1 optional.
	self
		should: [
		'cases 1: x -> x and false end' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
