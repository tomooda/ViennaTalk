Class {
	#name : 'ViennaSequenceIndicesNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaSequenceIndicesNodeTest >> testMaximalType [

	self
		assert: 'inds [1,2,nil]' asViennaExpressionAst maximalType
		equals: ViennaType nat1 set1.

	self
		assert: 'inds []' asViennaExpressionAst maximalType
		equals: ViennaType nat1 set.

	self
		should: [ 'inds {1,2,3}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
