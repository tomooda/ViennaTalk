Class {
	#name : #ViennaAlwaysStatementNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaAlwaysStatementNodeTest >> testMaximalType [

	self
		assert: 'always skip in skip' asViennaStatementAst maximalType
		equals: ViennaType unit.
	self
		should: [ 'always v := 0 in skip' asViennaStatementAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [ 'always skip in v := 0' asViennaStatementAst maximalType ]
		raise: ViennaTypeError
]
