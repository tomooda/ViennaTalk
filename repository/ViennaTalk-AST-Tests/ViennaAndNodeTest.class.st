Class {
	#name : 'ViennaAndNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaAndNodeTest >> testMaximalType [

	self
		assert: 'true and false' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		should: [ 'true and 1' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [ '1 and false' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
