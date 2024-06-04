Class {
	#name : 'ViennaSetComprehensionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaSetComprehensionNodeTest >> testMaximalType [

	self
		assert:
			'{x+1 | x in set {1,2,3} & x mod 2 = 0}' asViennaExpressionAst
				maximalType
		equals: ViennaType nat1 set.
	self
		assert:
			'{x+1.0 | x in set {1,2,3} & x mod 2 = 0}' asViennaExpressionAst
				maximalType
		equals: ViennaType real set.
	self
		should: [
			'{x^[] | x in set {1,2,3} & x mod 2 = 0}' asViennaExpressionAst
				maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			'{x | x in set {1,2,3} & x mod 2}' asViennaExpressionAst
				maximalType ]
		raise: ViennaTypeError
]
