Class {
	#name : #ViennaExists1ExpressionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaExists1ExpressionNodeTest >> testMaximalType [

	self
		assert:
			'exists1 x in set {1, 2} & x mod 2 = 1' asViennaExpressionAst
				maximalType
		equals: ViennaType bool.
	self
		should: [
			'exists1 x in set {1, 2} & x mod nil = 1' asViennaExpressionAst
				typecheck ]
		raise: ViennaTypeError.
	self
		should: [
		'exists1 x : char & x mod nil = 1' asViennaExpressionAst typecheck ]
		raise: ViennaTypeError
]
