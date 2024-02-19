Class {
	#name : #ViennaUndefinedExpressionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaUndefinedExpressionNodeTest >> testMaximalType [

	self
		assert: 'undefined' asViennaExpressionAst maximalType
		equals: ViennaType any
]
