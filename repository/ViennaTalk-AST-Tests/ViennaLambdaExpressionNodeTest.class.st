Class {
	#name : #ViennaLambdaExpressionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #test }
ViennaLambdaExpressionNodeTest >> testMaximalType [

	self
		assert: 'lambda x:nat, y:char & if x < 10 then y else nil'
				asViennaExpressionAst typecheck
		equals: ViennaType nat * ViennaType char -> ViennaType char optional
]
