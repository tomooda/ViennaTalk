Class {
	#name : #ViennaSequenceHeadNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaSequenceHeadNodeTest >> testMaximalType [

	self
		assert: 'hd [1,2,nil]' asViennaExpressionAst maximalType
		equals: ViennaType nat1 optional.

	self
		should: [ 'hd []' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [ 'hd {1,2,3}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
