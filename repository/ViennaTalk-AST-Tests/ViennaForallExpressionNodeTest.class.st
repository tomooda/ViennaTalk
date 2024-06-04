Class {
	#name : 'ViennaForallExpressionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaForallExpressionNodeTest >> testMaximalType [

	self
		assert: 'forall x, y in set {1, 2}, z in seq [1,2] & x mod y = z'
				asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		should: [
			'forall x, y in set {1, 2}, z in seq "12" & x mod y = z'
				asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			'forall x, y in set {1, 2}, z in seq [1,2] & x mod nil = z'
				asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
