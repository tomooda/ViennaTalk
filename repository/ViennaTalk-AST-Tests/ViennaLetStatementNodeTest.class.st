Class {
	#name : 'ViennaLetStatementNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaLetStatementNodeTest >> testMaximalType [

	self
		assert: 'let x:nat = 1, y = nil in if x > 10 then skip else skip'
				asViennaStatementAst maximalType
		equals: ViennaType unit.
	self
		should: [
		'let x:bool = 1, y = nil in skip' asViennaStatementAst maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			'let x:nat = 1, y = nil in if x > y then skip' asViennaStatementAst
				maximalType ]
		raise: ViennaTypeError
]
