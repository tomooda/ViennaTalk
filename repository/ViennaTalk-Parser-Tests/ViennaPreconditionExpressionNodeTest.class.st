Class {
	#name : #ViennaPreconditionExpressionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaPreconditionExpressionNodeTest >> testMaximalType [

	self
		assert:
		'pre_(lambda x:nat & x, 1)' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		should: [
		'pre_(lambda x:nat & x+{}, 1)' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [
		'pre_(lambda x:nat & x, 1+nil)' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
