Class {
	#name : 'ViennaIdentityStatementNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaIdentityStatementNodeTest >> testMaximalType [

	self
		assert: 'skip' asViennaStatementAst maximalType
		equals: ViennaType unit
]
