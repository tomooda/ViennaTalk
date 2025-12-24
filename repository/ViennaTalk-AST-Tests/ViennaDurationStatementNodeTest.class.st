Class {
	#name : 'ViennaDurationStatementNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaDurationStatementNodeTest >> testMaximalType [

	self
		assert: 'duration (2+3) skip' asViennaStatementAst maximalType
		equals: ViennaType unit.
	self
		should: ['duration (false) skip' asViennaStatementAst maximalType]
		raise: ViennaTypeError
]
