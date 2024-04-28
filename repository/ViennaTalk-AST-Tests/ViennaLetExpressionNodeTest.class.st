Class {
	#name : #ViennaLetExpressionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaLetExpressionNodeTest >> testMaximalType [

	self
		assert: 'let x:nat = 1, y = nil in if x > 10 then x else y'
				asViennaExpressionAst maximalType
		equals: ViennaType nat1 optional.
	self
		should: [
			'let x:bool = 1, y = nil in if x > 10 then x else y'
				asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
		self
		should: [
			'let x:nat = 1, y = nil in if x > y then x else y'
				asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
