Class {
	#name : #ViennaSequenceComprehensionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #test }
ViennaSequenceComprehensionNodeTest >> testMaximalType [

	self
		assert:
			'[x+1 | x in set {1,2,3} & x mod 2 = 0]' asViennaExpressionAst
				maximalType
		equals: ViennaType nat1 seq.
	self
		assert:
			'[x+1.0 | x in set {1,2,3} & x mod 2 = 0]' asViennaExpressionAst
				maximalType
		equals: ViennaType real seq.
	self
		should: [
			'[x^[] | x in set {1,2,3} & x mod 2 = 0]' asViennaExpressionAst
				maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			'[x | x in set {1,2,3} & x mod 2]' asViennaExpressionAst
				maximalType ]
		raise: ViennaTypeError
]
