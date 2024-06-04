Class {
	#name : 'ViennaSequenceForLoopNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaSequenceForLoopNodeTest >> testMaximalType [

	self
		assert: ('for mk_(x, y):nat*[char] in [mk_(1, nil)] do skip'
				 asViennaStatementAst
				 typecheck;
				 patternOrBind) pattern first first typecheck
		equals: ViennaType nat1.
	self
		should: [
			'for mk_(x, y, z):nat*[char] in [mk_(1, nil)] do skip'
				asViennaStatementAst typecheck ]
		raise: ViennaTypeError.
	self
		should: [
			'for mk_(x, y):nat*[char] in {mk_(1, nil)} do skip'
				asViennaStatementAst typecheck ]
		raise: ViennaTypeError
]
