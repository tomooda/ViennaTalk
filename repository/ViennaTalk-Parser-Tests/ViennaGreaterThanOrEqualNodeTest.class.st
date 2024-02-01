Class {
	#name : #ViennaGreaterThanOrEqualNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaGreaterThanOrEqualNodeTest >> testTypecheck [

	self
		assert: ('3 >= 2' asViennaExpressionAst typecheck: ViennaType bool)
		equals: ViennaType bool.
	self
		assert:
		('3.14 >= 2' asViennaExpressionAst typecheck: ViennaType bool)
		equals: ViennaType bool.
	self
		should: [
		'3 >= true' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError
]
