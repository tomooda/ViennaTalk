Class {
	#name : 'ViennaMapInverseNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaMapInverseNodeTest >> testMaximalType [

	self
		assert:
			'inverse {1 |-> 2, 2 |-> 2, nil |-> 2}' asViennaExpressionAst
				maximalType
		equals: (ViennaType nat1 inmapTo: ViennaType nat1 optional).

	self
		assert: 'inverse { |-> }' asViennaExpressionAst maximalType
		equals: (ViennaType unit inmapTo: ViennaType unit).

	self
		should: [ 'inverse {1,2,3}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
