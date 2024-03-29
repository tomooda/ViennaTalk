"
A ViennaTokenConstructorNodeTest is a test class for testing the behavior of ViennaTokenConstructorNode
"
Class {
	#name : #ViennaTokenConstructorNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #test }
ViennaTokenConstructorNodeTest >> testMaximalType [

	self
		assert: 'mk_token(1)' asViennaExpressionAst maximalType
		equals: ViennaType token.
	self
		should: [ 'mk_token(1+nil)' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
