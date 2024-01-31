Class {
	#name : #ViennaAndNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaAndNodeTest >> testTypecheck [

	self
		assert:
		('true and false' asViennaExpressionAst typecheck: ViennaType bool)
		equals: ViennaType bool.
	self
		should: [
		'true and 1' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError.
	self
		should: [
		'1 and false' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError.
	self
		should: [
		'true and false' asViennaExpressionAst typecheck: ViennaType nat ]
		raise: ViennaTypeError
]
