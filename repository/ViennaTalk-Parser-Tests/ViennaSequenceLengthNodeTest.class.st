Class {
	#name : #ViennaSequenceLengthNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaSequenceLengthNodeTest >> testMaximalType [

	self
		assert: 'len [1,2,nil]' asViennaExpressionAst maximalType
		equals: ViennaType nat1.

	self
		assert: 'len []' asViennaExpressionAst maximalType
		equals: ViennaType nat.

	self
		should: [ 'len {1,2,3}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
