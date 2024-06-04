Class {
	#name : 'ViennaMapEnumerationNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaMapEnumerationNodeTest >> testMaximalType [

	self
		assert: '{1 |-> 2, 2.0 |-> nil}' asViennaExpressionAst maximalType
		equals: (ViennaType real inmapTo: ViennaType nat1 optional).
	self
		assert: '{1 |-> 2, 2.0 |-> 2, 3.0 |-> nil}' asViennaExpressionAst maximalType
		equals: (ViennaType real mapTo: ViennaType nat1 optional).
	self
		assert: '{|->}' asViennaExpressionAst maximalType
		equals: (ViennaType unit inmapTo: ViennaType unit).
	self
		should: [ '{1 + true |-> 0}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
