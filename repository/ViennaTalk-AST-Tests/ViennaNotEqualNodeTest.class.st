"
A ViennaNotEqualNodeTest is a test class for testing the behavior of ViennaNotEqualNode
"
Class {
	#name : #ViennaNotEqualNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaNotEqualNodeTest >> testMaximalType [

	self
		assert: '3 <> 2' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		assert: '"abc" <> "xyz"' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		should: [ '3 <> "3"' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
