Class {
	#name : #ViennaSequenceElementsNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaSequenceElementsNodeTest >> testMaximalType [

	self
		assert: 'elems [1,2,3]' asViennaExpressionAst maximalType
		equals: ViennaType nat1 set1.

	self
		assert: 'elems []' asViennaExpressionAst maximalType
		equals: ViennaType unit set.

	self
		should: [ 'elems {1,2,3}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
