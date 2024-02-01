Class {
	#name : #ViennaLessThanOrEqualNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaLessThanOrEqualNodeTest >> testTypecheck [

	self
		assert: ('3 <= 2' asViennaExpressionAst typecheck: ViennaType bool)
		equals: ViennaType bool.
	self
		assert:
		('3.14 <= 2' asViennaExpressionAst typecheck: ViennaType bool)
		equals: ViennaType bool.
	self
		should: [
		'3 <= true' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError
]
