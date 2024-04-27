Class {
	#name : #ViennaMapComprehensionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #test }
ViennaMapComprehensionNodeTest >> testMaximalType [

	self
		assert:
			'{x |-> y | x, y in set {1,2,3} & x > y}' asViennaExpressionAst
				maximalType
		equals: (ViennaType nat1 mapTo: ViennaType nat1).
	self
		should: [
			'{x |-> y | x, y in set {1,2,3} & x + y}' asViennaExpressionAst
				maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			'{x |-> y + nil | x, y in set {1,2,3} & x + y}'
				asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
