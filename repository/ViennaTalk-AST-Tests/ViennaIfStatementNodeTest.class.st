Class {
	#name : 'ViennaIfStatementNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaIfStatementNodeTest >> testMaximalType [

	self
		assert:
			('operations op:()==>nat op() == if 1 > 0 then return 1 else return 2'
				 asViennaDocumentAst resolveIdentifier: 'op') statement
				maximalType
		equals: ViennaType nat1.
	self
		assert: ('operations op:()==>nat op() == if 1 > 0 then return 1'
				 asViennaDocumentAst resolveIdentifier: 'op') statement
				maximalType
		equals: ViennaType nat1.
	self
		assert:
			('operations op:()==>int op() == if 1 > 0 then return 0 else return 1'
				 asViennaDocumentAst resolveIdentifier: 'op') statement
				maximalType
		equals: ViennaType nat
]
