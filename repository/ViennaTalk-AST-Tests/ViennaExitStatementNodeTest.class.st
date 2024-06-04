Class {
	#name : 'ViennaExitStatementNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaExitStatementNodeTest >> testMaximalType [

	self
		assert: 'exit 1' asViennaStatementAst maximalType
		equals: ViennaType unit.
	self
		should: [ 'exit (1 + nil)' asViennaStatementAst maximalType ]
		raise: ViennaTypeError
]
