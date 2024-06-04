Class {
	#name : 'ViennaMapRangeNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaMapRangeNodeTest >> testMaximalType [

	self
		assert:
		'rng {1 |-> 2,2 |-> 3,nil |-> nil}' asViennaExpressionAst
			maximalType
		equals: ViennaType nat1 optional set.

	self
		assert: 'rng { |-> }' asViennaExpressionAst maximalType
		equals: ViennaType unit set.

	self
		should: [ 'rng {1,2,3}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
