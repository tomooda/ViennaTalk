Class {
	#name : #ViennaSequenceTailNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaSequenceTailNodeTest >> testMaximalType [

	self
		assert: 'tl [1,2,nil]' asViennaExpressionAst maximalType
		equals: ViennaType nat1 optional seq.

	self
		assert: 'tl []' asViennaExpressionAst maximalType
		equals: ViennaType unit seq.

	self
		should: [ 'tl {1,2,3}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
