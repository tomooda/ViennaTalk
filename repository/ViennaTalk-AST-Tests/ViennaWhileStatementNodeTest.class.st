Class {
	#name : 'ViennaWhileStatementNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaWhileStatementNodeTest >> testMaximalType [

	self
		assert: 'while 1 > 0 do skip' asViennaStatementAst maximalType
		equals: ViennaType unit.
	self
		should: [ 'while 1 do skip' asViennaStatementAst maximalType ]
		raise: ViennaTypeError
]
