Class {
	#name : #ViennaSetForLoopNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaSetForLoopNodeTest >> testMaximalType [

	self
		assert:
			('for all mk_(x, y) in set {mk_(1, nil)} do skip'
				 asViennaStatementAst
				 typecheck;
				 pattern) first first typecheck
		equals: ViennaType nat1.
	self
		should: [
			'for all mk_(x, y, z) in set {mk_(1, nil)} do skip'
				asViennaStatementAst typecheck ]
		raise: ViennaTypeError.
	self
		should: [
			'for all mk_(x, y) in set [mk_(1, nil)] do skip'
				asViennaStatementAst typecheck ]
		raise: ViennaTypeError
]
