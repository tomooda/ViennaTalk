Class {
	#name : #ViennaDistributedSetUnionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaDistributedSetUnionNodeTest >> testMaximalType [

	self
		assert: 'dunion {{1,2}, {3,nil}}' asViennaExpressionAst maximalType
		equals: ViennaType nat1 optional set1.

	self
		assert: 'dunion {{}}' asViennaExpressionAst maximalType
		equals: ViennaType unit set.

	self
		should: [ 'dunion []' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
