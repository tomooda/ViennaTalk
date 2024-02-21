"
A ViennaExplicitOperationDefinitionNodeTest is a test class for testing the behavior of ViennaExplicitOperationDefinitionNode
"
Class {
	#name : #ViennaExplicitOperationDefinitionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaExplicitOperationDefinitionNodeTest >> testMaximalType [

	self
		assert: ('operations op:()==>() op() == skip' asViennaDocumentAst
				 resolveIdentifier: 'op') maximalType
		equals: ViennaType unit ==> ViennaType unit.
	self
		assert:
			('operations op:nat==>[char] op(x) == if x = 0 then return nil else return ''c'' pre x > 0 post RESULT <> nil'
				 asViennaDocumentAst resolveIdentifier: 'op') maximalType
		equals: ViennaType nat ==> ViennaType char optional.
	self
		should: [
			('operations op:()==>() op(x) == skip' asViennaDocumentAst
				 resolveIdentifier: 'op') maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			('operations op:nat==>() op() == skip' asViennaDocumentAst
				 resolveIdentifier: 'op') maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			('operations op:()==>nat op() == skip' asViennaDocumentAst
				 resolveIdentifier: 'op') maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			('operations op:()==>() op() == return 1' asViennaDocumentAst
				 resolveIdentifier: 'op') maximalType ]
		raise: ViennaTypeError
]
