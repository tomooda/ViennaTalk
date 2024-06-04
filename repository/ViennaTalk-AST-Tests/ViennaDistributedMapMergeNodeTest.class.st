Class {
	#name : 'ViennaDistributedMapMergeNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaDistributedMapMergeNodeTest >> testMaximalType [

	self
		assert:
		'merge {{1 |-> 2}, {nil |-> 2.1}}' asViennaExpressionAst maximalType
		equals: (ViennaType nat1 optional mapTo: ViennaType real).

	self
		assert: 'merge {{|->}}' asViennaExpressionAst maximalType
		equals: (ViennaType unit inmapTo: ViennaType unit).

	self
		should: [ 'merge []' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
