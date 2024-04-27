Class {
	#name : #ViennaIotaExpressionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #test }
ViennaIotaExpressionNodeTest >> testMaximalType [

	self
		assert: 'iota x in set {1,2,3} & x mod 2 = 0' asViennaExpressionAst
				maximalType
		equals: ViennaType nat1.
	self
		should: [
			'iota x in set {1,2,3, 4.0} & x mod 2' asViennaExpressionAst
				maximalType ]
		raise: ViennaTypeError
]
