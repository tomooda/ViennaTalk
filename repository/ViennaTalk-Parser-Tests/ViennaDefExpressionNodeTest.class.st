Class {
	#name : #ViennaDefExpressionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaDefExpressionNodeTest >> testMaximalType [

	self
		assert: 'def x = 1; y = x; x = 0.1 in y' asViennaExpressionAst maximalType
		equals: ViennaType nat1
]
