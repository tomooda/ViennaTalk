Class {
	#name : #ViennaArithmeticDivideNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaArithmeticDivideNodeTest >> testTypecheck [

	self
		assert:
		('4 / 2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType real.
	self
		assert:
		('3.14 / 2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType real.
	self
		should: [
		'3.14 / true' asViennaExpressionAst typecheck: ViennaType real ]
		raise: ViennaTypeError.
	self
		should: [
		'true / 2' asViennaExpressionAst typecheck: ViennaType real ]
		raise: ViennaTypeError.
	self
		should: [
		'3.14 / 2' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError
]
