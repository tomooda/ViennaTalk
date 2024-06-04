Class {
	#name : 'ViennaMapDomainNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaMapDomainNodeTest >> testMaximalType [

	self
		assert:
		'dom {1 |-> 2,2 |-> 3,nil |-> nil}' asViennaExpressionAst
			maximalType
		equals: ViennaType nat1 optional set.

	self
		assert: 'dom { |-> }' asViennaExpressionAst maximalType
		equals: ViennaType unit set.

	self
		should: [ 'dom {1,2,3}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
