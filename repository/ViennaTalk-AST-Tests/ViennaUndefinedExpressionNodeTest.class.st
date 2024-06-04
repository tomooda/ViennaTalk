Class {
	#name : 'ViennaUndefinedExpressionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaUndefinedExpressionNodeTest >> testMaximalType [

	self
		assert: 'undefined' asViennaExpressionAst maximalType
		equals: ViennaType any
]
