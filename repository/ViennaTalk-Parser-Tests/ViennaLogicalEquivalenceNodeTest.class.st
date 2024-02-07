Class {
	#name : #ViennaLogicalEquivalenceNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaLogicalEquivalenceNodeTest >> testMaximalType [

	self
		assert: 'true <=> false' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		should: [ '3 <=> 2' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
