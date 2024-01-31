Class {
	#name : #ViennaArithmaticPlusNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaArithmaticPlusNodeTest >> testTypecheck [

	self
		assert: ('3 + 2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType nat1.
	self
		assert: ('3 + 0' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType nat1.
	self
		assert: ('0 + 0' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType nat.
	self
		assert: ('3 + -2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType int.
	self
		assert:
		('3.14 + 2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType real.
	self
		should: [
		'3.14 + true' asViennaExpressionAst typecheck: ViennaType real ]
		raise: ViennaTypeError.
	self
		should: [
		'true + 2' asViennaExpressionAst typecheck: ViennaType real ]
		raise: ViennaTypeError.
	self
		should: [
		'3.14 + 2' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError
]
