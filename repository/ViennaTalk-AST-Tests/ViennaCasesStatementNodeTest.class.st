Class {
	#name : 'ViennaCasesStatementNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaCasesStatementNodeTest >> testMaximalType [

	self
		assert: 'cases [1,2,3]: [x]^- -> skip, others -> skip end'
				asViennaStatementAst maximalType
		equals: ViennaType unit.
	self
		should: [
		'cases 1: x -> v := nil end' asViennaStatementAst maximalType ]
		raise: ViennaTypeError
]
