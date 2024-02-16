Class {
	#name : #ViennaTupleSelectNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #test }
ViennaTupleSelectNodeTest >> testMaximalType [

	self
		assert: 'mk_(1, nil, "").#1' asViennaExpressionAst maximalType
		equals: ViennaType nat1.
	self
		should: [ 'mk_(1, nil, "").#5' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
