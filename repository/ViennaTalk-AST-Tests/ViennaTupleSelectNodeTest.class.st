Class {
	#name : 'ViennaTupleSelectNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaTupleSelectNodeTest >> testMaximalType [

	self
		assert: 'mk_(1, nil, "").#1' asViennaExpressionAst maximalType
		equals: ViennaType nat1.
	self
		should: [ 'mk_(1, nil, "").#5' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
