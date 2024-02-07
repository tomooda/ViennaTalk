Class {
	#name : #ViennaArithmeticIntegerDivisionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaArithmeticIntegerDivisionNodeTest >> testMaximalType [

	self
		assert: '3 div 2' asViennaExpressionAst maximalType
		equals: ViennaType int.
	self
		assert: '3 div 2' asViennaExpressionAst maximalType
		equals: ViennaType int.
	self
		should: [ '3 div true' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [ 'true div 2' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
