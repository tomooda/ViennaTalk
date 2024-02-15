Class {
	#name : #ViennaMapEnumerationNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #test }
ViennaMapEnumerationNodeTest >> testMaximalType [

	self
		assert: '{1 |-> 2, 2.0 |-> nil}' asViennaExpressionAst maximalType
		equals: (ViennaType real mapTo: ViennaType nat1 optional).
	self
		assert: '{|->}' asViennaExpressionAst maximalType
		equals: (ViennaType unit mapTo: ViennaType unit).
	self
		should: [ '{1 + true |-> 0}' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
