Class {
	#name : 'ViennaFloorNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaFloorNodeTest >> testMaximalType [

	self
		assert: 'floor 3.14' asViennaExpressionAst maximalType
		equals: ViennaType int.

	self
		assert: 'floor 1' asViennaExpressionAst maximalType
		equals: ViennaType nat1.

	self
		should: [ 'floor nil' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
