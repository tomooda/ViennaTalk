Class {
	#name : 'ViennaGreaterThanOrEqualNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaGreaterThanOrEqualNodeTest >> testMaximalType [

	self
		assert: '3 >= 2' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		assert: '3.14 >= 2' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		should: [ '3 >= true' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
