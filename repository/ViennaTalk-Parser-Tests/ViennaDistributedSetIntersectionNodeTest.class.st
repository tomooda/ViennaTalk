Class {
	#name : #ViennaDistributedSetIntersectionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaDistributedSetIntersectionNodeTest >> testMaximalType [

	self
		assert: 'dinter {{1,2}, {3,nil}}' asViennaExpressionAst maximalType
		equals: ViennaType nat1 optional set.

	self
		assert: 'dinter {{}}' asViennaExpressionAst maximalType
		equals: ViennaType unit set.

	self
		should: [ 'dinter []' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
