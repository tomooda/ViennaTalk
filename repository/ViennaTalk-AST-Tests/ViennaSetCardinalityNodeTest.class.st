Class {
	#name : #ViennaSetCardinalityNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaSetCardinalityNodeTest >> testMaximalType [

	self
		assert: 'card {1,2,nil}' asViennaExpressionAst maximalType
		equals: ViennaType nat1.

	self
		assert: 'card {}' asViennaExpressionAst maximalType
		equals: ViennaType nat.

	self
		should: [ 'card [1,2,3]' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
