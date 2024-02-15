Class {
	#name : #ViennaSetRangeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaSetRangeNodeTest >> testMaximalType [

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
