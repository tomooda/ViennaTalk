Class {
	#name : #ViennaArithmaticModNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaArithmaticModNodeTest >> testTypecheck [

	self
		assert: ('3 mod 2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType real.
	self
		assert: ('-3 mod 2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType real.
	self
		assert: ('3 mod -2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType real.
	self
		assert:
		('3.14 mod 2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType real.
	self
		should: [
		'3.14 mod true' asViennaExpressionAst typecheck: ViennaType real ]
		raise: ViennaTypeError.
	self
		should: [
		'true mod 2' asViennaExpressionAst typecheck: ViennaType real ]
		raise: ViennaTypeError.
	self
		should: [
		'3.14 mod 2' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError
]
