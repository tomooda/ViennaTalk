Class {
	#name : #ViennaSetEnumerationNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaSetEnumerationNodeTest >> testMaximalType [

	self
		assert: '{1,2,0, -1}' asViennaExpressionAst maximalType
		equals: ViennaType int set1.
	self
		assert: '{1,2,0, -1, "123"}' asViennaExpressionAst maximalType
		equals: (ViennaType int | ViennaType char seq1) set1
]
