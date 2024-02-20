Class {
	#name : #ViennaIndexForLoopNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaIndexForLoopNodeTest >> testMaximalType [

	self
		assert: ('for i = 0 to 10 do skip' asViennaStatementAst
				 typecheck;
				 patternIdentifier) typecheck
		equals: ViennaType nat.
	self
		assert: ('for i = 0 to 10 by 0.1 do skip' asViennaStatementAst
				 typecheck;
				 patternIdentifier) typecheck
		equals: ViennaType real.
	self
		assert: ('for i = 10 to 0 by -1 do skip' asViennaStatementAst
				 typecheck;
				 patternIdentifier) typecheck
		equals: ViennaType nat.
	self
		assert:
			('operations op:()==>real op() == for i = 1 to 2 do return i'
				 asViennaDocumentAst resolveIdentifier: 'op') statement typecheck
		equals: ViennaType nat1.
	self
		should: [
			('for i = nil to 1 by -1 do skip' asViennaStatementAst
				 typecheck;
				 patternIdentifier) typecheck ]
		raise: ViennaTypeError.
	self
		should: [
			('for i = 1 to nil by -1 do skip' asViennaStatementAst
				 typecheck;
				 patternIdentifier) typecheck ]
		raise: ViennaTypeError.
	self
		should: [
			('for i = 1 to 10 by nil do skip' asViennaStatementAst
				 typecheck;
				 patternIdentifier) typecheck ]
		raise: ViennaTypeError
]
