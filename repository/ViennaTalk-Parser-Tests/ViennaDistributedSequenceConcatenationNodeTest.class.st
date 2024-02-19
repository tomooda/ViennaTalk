Class {
	#name : #ViennaDistributedSequenceConcatenationNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaDistributedSequenceConcatenationNodeTest >> testMaximalType [

	self
		assert: 'conc [[1,2], [3,nil]]' asViennaExpressionAst maximalType
		equals: ViennaType nat1 optional seq1.

	self
		assert: 'conc [[]]' asViennaExpressionAst maximalType
		equals: ViennaType unit seq.

	self
		should: [ 'conc []' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError.

	self
		should: [ 'conc {}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
