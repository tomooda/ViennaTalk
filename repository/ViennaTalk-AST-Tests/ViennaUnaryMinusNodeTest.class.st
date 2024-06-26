Class {
	#name : 'ViennaUnaryMinusNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaUnaryMinusNodeTest >> testMaximalType [

	self
		assert: '-2' asViennaExpressionAst maximalType
		equals: ViennaType int.
	self
		assert: '-1.41421356' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		should: [ '-nil' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
