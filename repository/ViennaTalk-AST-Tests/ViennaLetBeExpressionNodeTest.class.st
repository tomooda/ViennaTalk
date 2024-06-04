Class {
	#name : 'ViennaLetBeExpressionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaLetBeExpressionNodeTest >> testMaximalType [

	self
		assert: 'let x, y in set {1,2,3} be st x mod 2 = 0 in x + y'
				asViennaExpressionAst typecheck
		equals: ViennaType nat1.
	self
		should: [
			'let x, y in set {1,2,3} be st x mod 2 in x + y'
				asViennaExpressionAst typecheck ]
		raise: ViennaTypeError.
	self
		should: [
			'let x, y in set {1,2,3} be st x mod 2 = 0 in x + y + nil'
				asViennaExpressionAst typecheck ]
		raise: ViennaTypeError
]
