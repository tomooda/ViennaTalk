Class {
	#name : #ViennaEqualNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaEqualNodeTest >> testMaximalType [

	self
		assert: '3 = 2' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		assert: '"abc" = "xyz"' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		should: [ '3 = "3"' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
