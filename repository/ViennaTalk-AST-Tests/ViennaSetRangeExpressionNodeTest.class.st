Class {
	#name : #ViennaSetRangeExpressionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaSetRangeExpressionNodeTest >> testMaximalType [

	self
		assert: '{1,...,10}' asViennaExpressionAst maximalType
		equals: ViennaType nat1 set.
	self
		assert: '{-1,...,10}' asViennaExpressionAst maximalType
		equals: ViennaType int set.
	self
		should: [ '{-1,...,nil}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
