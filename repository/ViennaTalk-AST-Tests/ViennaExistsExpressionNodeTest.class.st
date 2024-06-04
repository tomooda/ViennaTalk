Class {
	#name : 'ViennaExistsExpressionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaExistsExpressionNodeTest >> testMaximalType [

	self
		assert: 'exists x, y in set {1, 2}, z in seq [1,2] & x mod y = z'
				asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		should: [
			'exists x, y in set {1, 2}, z in seq "12" & x mod y = z'
				asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			'exists x, y in set {1, 2}, z in seq [1,2] & x mod nil = z'
				asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
