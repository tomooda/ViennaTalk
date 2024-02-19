Class {
	#name : #ViennaFinitePowerSetNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaFinitePowerSetNodeTest >> testMaximalType [

	self
		assert: 'power {1,2,nil}' asViennaExpressionAst maximalType
		equals: ViennaType nat1 optional set set1.

	self
		assert: 'power {}' asViennaExpressionAst maximalType
		equals: ViennaType unit set set1.

	self
		should: [ 'power []' asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
