Class {
	#name : #ViennaArithmaticRemNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaArithmaticRemNodeTest >> testTypecheck [

	self
		assert: ('3 rem 2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType nat.
	self
		assert:
		('-3 rem 2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType int.
	self
		assert:
		('3 rem -2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType nat.
	self
		assert:
		('3.14 rem 2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType real.
	self
		should: [
		'3.14 rem true' asViennaExpressionAst typecheck: ViennaType real ]
		raise: ViennaTypeError.
	self
		should: [
		'true rem 2' asViennaExpressionAst typecheck: ViennaType real ]
		raise: ViennaTypeError.
	self
		should: [
		'3.14 rem 2' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError
]
