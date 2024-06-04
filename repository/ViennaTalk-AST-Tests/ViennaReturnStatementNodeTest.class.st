Class {
	#name : 'ViennaReturnStatementNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaReturnStatementNodeTest >> testMaximalType [

	self
		assert: ('operations op:()==>() op() == return' asViennaDocumentAst
				 resolveIdentifier: 'op') statement maximalType
		equals: ViennaType unit.
	self
		assert:
			('operations op:()==>real op() == return 1' asViennaDocumentAst
				 resolveIdentifier: 'op') statement maximalType
		equals: ViennaType nat1.
	self
		should: [
			('operations op:()==>() op() == return 1' asViennaDocumentAst
				 resolveIdentifier: 'op') statement maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			('operations op:()==>real op() == return' asViennaDocumentAst
				 resolveIdentifier: 'op') statement maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			('operations op:()==>real op() == return nil' asViennaDocumentAst
				 resolveIdentifier: 'op') statement maximalType ]
		raise: ViennaTypeError
]
