Class {
	#name : #ViennaImplyNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaImplyNodeTest >> testTypecheck [

	self
		assert:
		('true => false' asViennaExpressionAst typecheck: ViennaType bool)
		equals: ViennaType bool.
	self
		should: [
		'1 => false' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError.
	self
		should: [
		'true => 0' asViennaExpressionAst typecheck: ViennaType bool ]
		raise: ViennaTypeError.
	self
		should: [
		'true => false' asViennaExpressionAst typecheck: ViennaType real ]
		raise: ViennaTypeError
]
