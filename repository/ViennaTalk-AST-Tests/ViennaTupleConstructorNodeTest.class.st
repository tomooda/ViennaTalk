"
A ViennaTupleConstructorNodeTest is a test class for testing the behavior of ViennaTupleConstructorNode
"
Class {
	#name : 'ViennaTupleConstructorNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaTupleConstructorNodeTest >> testMaximalType [

	self
		assert: 'mk_(1, nil, [1,2,3])' asViennaExpressionAst maximalType
		equals:
		ViennaType nat1 * ViennaType unit optional * ViennaType nat1 seq1
]
