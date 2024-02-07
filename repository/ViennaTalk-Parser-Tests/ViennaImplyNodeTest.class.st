Class {
	#name : #ViennaImplyNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaImplyNodeTest >> testMaximalType [

	self
		assert: 'true => false' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		should: [ '1 => false' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [ 'true => 0' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
