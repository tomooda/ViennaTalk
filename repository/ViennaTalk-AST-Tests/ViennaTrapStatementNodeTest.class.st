Class {
	#name : #ViennaTrapStatementNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaTrapStatementNodeTest >> testMaximalType [

	self
		assert: 'trap p with skip in skip' asViennaStatementAst maximalType
		equals: ViennaType unit.
	self
		assert:
			('operations op:()==>real op() == trap p:nat with return p in skip'
				 asViennaDocumentAst resolveIdentifier: 'op') statement
				maximalType
		equals: ViennaType nat
]
