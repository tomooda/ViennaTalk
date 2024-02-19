Class {
	#name : #ViennaNotNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaNotNodeTest >> testMaximalType [

	self
		assert: 'not true' asViennaExpressionAst maximalType
		equals: ViennaType bool.

	self
		assert:
		'not (if 1 > 0 then true else nil)' asViennaExpressionAst
			maximalType
		equals: ViennaType bool.

	self
		should: [ 'not nil' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
