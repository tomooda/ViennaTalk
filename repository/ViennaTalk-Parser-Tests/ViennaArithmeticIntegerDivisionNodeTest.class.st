Class {
	#name : #ViennaArithmeticIntegerDivisionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaArithmeticIntegerDivisionNodeTest >> testTypecheck [

	self
		assert: ('3 div 2' asViennaExpressionAst typecheck: ViennaType int)
		equals: ViennaType int.
	self
		assert: ('3 div 2' asViennaExpressionAst typecheck: ViennaType real)
		equals: ViennaType int.
	self
		should: [
		'3 div true' asViennaExpressionAst typecheck: ViennaType int ]
		raise: ViennaTypeError.
	self
		should: [
		'true div 2' asViennaExpressionAst typecheck: ViennaType int ]
		raise: ViennaTypeError.
	self
		should: [
		'3 div 2' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError
]
