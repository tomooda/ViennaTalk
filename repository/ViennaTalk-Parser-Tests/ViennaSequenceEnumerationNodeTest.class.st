Class {
	#name : #ViennaSequenceEnumerationNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaSequenceEnumerationNodeTest >> testMaximalType [

	self
		assert: '[1,2,0, -1]' asViennaExpressionAst maximalType
		equals: ViennaType int seq1.
	self
		assert: '[1,2,0, -1, "123"]' asViennaExpressionAst maximalType
		equals: (ViennaType int | ViennaType char seq1) seq1
]
