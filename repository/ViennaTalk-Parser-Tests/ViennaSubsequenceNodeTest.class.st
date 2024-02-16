Class {
	#name : #ViennaSubsequenceNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #test }
ViennaSubsequenceNodeTest >> testMaximalType [

	self
		assert: '[10, 11, 12](1,...,3)' asViennaExpressionAst maximalType
		equals: ViennaType nat1 seq
]
