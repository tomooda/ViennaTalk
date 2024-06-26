Class {
	#name : 'ViennaIfExpressionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaIfExpressionNodeTest >> testMaximalType [

	self
		assert: 'if 1 > 2 then 1 elseif 2 > 3 then nil else 3.14'
				asViennaExpressionAst maximalType
		equals: ViennaType real optional.
	self
		should: [
			'if 1 + 2 then 1 elseif 2 > 3 then nil else 3.14'
				asViennaExpressionAst maximalType ]
		raise: ViennaTypeError
]
