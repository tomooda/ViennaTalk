Class {
	#name : 'ViennaErrorStatementNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaErrorStatementNodeTest >> testMaximalType [

	self
		assert: 'error' asViennaStatementAst maximalType
		equals: ViennaType unit
]
