Class {
	#name : #ViennaTixeStatementNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaTixeStatementNodeTest >> testMaximalType [

	self
		assert: 'tixe {p |-> skip} in skip' asViennaStatementAst maximalType
		equals: ViennaType unit.
	self
		assert:
			('operations op:()==>real op() == tixe {p:nat |-> return p} in skip'
				 asViennaDocumentAst resolveIdentifier: 'op') statement
				maximalType
		equals: ViennaType nat
]
