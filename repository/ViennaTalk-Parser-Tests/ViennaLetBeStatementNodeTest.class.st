Class {
	#name : #ViennaLetBeStatementNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaLetBeStatementNodeTest >> testMaximalType [

	self
		assert: 'let x, y in set {1,2,3} be st x mod 2 = 0 in skip'
				asViennaStatementAst typecheck
		equals: ViennaType unit.
	self
		should: [
			'let x, y in set {1,2,3} be st x mod 2 in skip'
				asViennaStatementAst typecheck ]
		raise: ViennaTypeError.
	self
		should: [
			'let x, y in set {1,2,3} be st x mod 2 = 0 in x := y'
				asViennaStatementAst typecheck ]
		raise: ViennaTypeError
]
