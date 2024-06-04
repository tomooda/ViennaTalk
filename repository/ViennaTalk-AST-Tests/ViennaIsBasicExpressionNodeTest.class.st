Class {
	#name : 'ViennaIsBasicExpressionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaIsBasicExpressionNodeTest >> testMaximalType [

	self
		assert: 'is_nat(1)' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		assert: 'is_nat("abc")' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		should: [ 'is_nat(1 and 2)' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
