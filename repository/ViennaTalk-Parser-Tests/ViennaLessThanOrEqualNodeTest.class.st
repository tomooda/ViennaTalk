Class {
	#name : #ViennaLessThanOrEqualNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaLessThanOrEqualNodeTest >> testMaximalType [

	self
		assert: '3 <= 2' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		assert: '3.14 <= 2' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		should: [ '3 <= true' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
