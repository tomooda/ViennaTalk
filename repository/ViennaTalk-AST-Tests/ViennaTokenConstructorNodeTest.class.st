"
A ViennaTokenConstructorNodeTest is a test class for testing the behavior of ViennaTokenConstructorNode
"
Class {
	#name : 'ViennaTokenConstructorNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaTokenConstructorNodeTest >> testMaximalType [

	self
		assert: 'mk_token(1)' asViennaExpressionAst maximalType
		equals: ViennaType token.
	self
		should: [ 'mk_token(1+nil)' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
