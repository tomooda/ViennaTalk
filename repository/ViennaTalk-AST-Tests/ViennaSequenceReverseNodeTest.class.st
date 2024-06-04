Class {
	#name : 'ViennaSequenceReverseNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaSequenceReverseNodeTest >> testMaximalType [

	self
		assert: 'reverse [1,2,nil]' asViennaExpressionAst maximalType
		equals: ViennaType nat1 optional seq1.

	self
		assert: 'reverse []' asViennaExpressionAst maximalType
		equals: ViennaType unit seq.

	self
		should: [ 'reverse {1,2,3}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
