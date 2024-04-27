Class {
	#name : #ViennaUnaryPlusNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaUnaryPlusNodeTest >> testMaximalType [

	self
		assert: '+2' asViennaExpressionAst maximalType
		equals: ViennaType nat1.
	self
		assert: '+1.41421356' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		should: [ '+nil' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
