Class {
	#name : #ViennaEqualNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaEqualNodeTest >> testTypecheck [

	self
		assert: ('3 = 2' asViennaExpressionAst typecheck: ViennaType bool)
		equals: ViennaType bool.
	self
		assert:
		('"abc" = "xyz"' asViennaExpressionAst typecheck: ViennaType bool)
		equals: ViennaType bool.
	self
		should: [
		'3 = "3"' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError
]